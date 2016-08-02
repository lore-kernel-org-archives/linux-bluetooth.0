Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BlueZ] core/adapter: Add support for enabling privacy
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAEJBhKMfYQHA-o+RmnwWJv+PQ=K4=jLEDqZKYHo5TjCJOrb-A@mail.gmail.com>
Date: Tue, 2 Aug 2016 11:25:58 +0200
Cc: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Message-Id: <F2142ABB-C457-4554-B8A4-00C4BA7E59F5@holtmann.org>
References: <1470052433-21116-1-git-send-email-michal.narajowski@codecoup.pl> <772531BA-59CA-44E3-B8F1-DEA3FD64C2FF@holtmann.org> <CAAEJBhKMfYQHA-o+RmnwWJv+PQ=K4=jLEDqZKYHo5TjCJOrb-A@mail.gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> This adds support for loading local IRK key when adapter is configured.
>>> In case IRK is not present new key is generated and stored.
>>> ---
>>> src/adapter.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>> 1 file changed, 136 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/src/adapter.c b/src/adapter.c
>>> index 3742398..fc8d10c 100644
>>> --- a/src/adapter.c
>>> +++ b/src/adapter.c
>>> @@ -433,6 +433,12 @@ static void store_adapter_info(struct btd_adapter *adapter)
>>> 
>>>      key_file = g_key_file_new();
>>> 
>>> +     ba2str(&adapter->bdaddr, address);
>>> +     snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
>>> +
>>> +     /* IRK must be preserved in the file, so load contents first */
>>> +     g_key_file_load_from_file(key_file, filename, 0, NULL);
>>> +
>> 
>> is this really needed? I mean, the IRK should be already present in memory and synced to the settings file after its creation. Sounds to me like we are hacking around a bug here.
> 
> After loading IRK to kernel it is no longer needed. I told Michał
> (offline) not to keep IRK in
> memory after loading it to kernel and just read settings before
> storing. Yet, if you prefer
> to just keep IRK in memory instead of reading file then I'm fine with it.

I don't like the hacking around of first loading it and then changing the key. We can certainly do it, but since none of our other fields are done like that, I think we should not. In that case we better create a %s/secrets file that we only use for storing these details.

And the only real downside for storing the IRK in memory is that we have to ensure that we memset it to zero before we free the structs. However that is something we should be doing with any mgmt message that contains keys anyway. Which is something we might not have done so far anyway. So worth while looking into fixing as well.

>>>      if (adapter->pairable_timeout != main_opts.pairto)
>>>              g_key_file_set_integer(key_file, "General", "PairableTimeout",
>>>                                      adapter->pairable_timeout);
>>> @@ -455,11 +461,6 @@ static void store_adapter_info(struct btd_adapter *adapter)
>>>              g_key_file_set_string(key_file, "General", "Alias",
>>>                                                      adapter->stored_alias);
>>> 
>>> -     ba2str(&adapter->bdaddr, address);
>>> -     snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
>>> -
>>> -     create_file(filename, S_IRUSR | S_IWUSR);
>>> -
>>>      str = g_key_file_to_data(key_file, &length, NULL);
>>>      g_file_set_contents(filename, str, length, NULL);
>>>      g_free(str);
>>> @@ -3141,6 +3142,130 @@ static struct conn_param *get_conn_param(GKeyFile *key_file, const char *peer,
>>>      return param;
>>> }
>>> 
>>> +static int generate_random_buffer(uint8_t *buf, int buflen)
>>> +{
>>> +     int fd;
>>> +
>>> +     fd = open("/dev/urandom", O_RDONLY);
>>> +     if (fd < 0) {
>>> +             error("Error opening /dev/urandom: %s", strerror(errno));
>>> +             return -1;
>>> +     }
>>> +
>>> +     if (read(fd, buf, buflen) != buflen) {
>>> +             error("Reading from urandom failed");
>>> +             close(fd);
>>> +             return -1;
>>> +     }
>>> +
>>> +     close(fd);
>>> +     return 0;
>>> +}
>> 
>> Please use bt_crypto_random_bytes so that we eventually can move this towards the new system call or AF_ALG since opening manually /dev/urandom in multiple locations is a bad idea.
>> 
>> I would not even mind creating bt_crypto_generate_irk for this simple purpose.
>> 
>>> +
>>> +static int generate_and_write_irk(uint8_t *irk, GKeyFile *key_file, const char *filename)
>>> +{
>>> +     char str_irk_out[33];
>>> +     gsize length = 0;
>>> +     int i;
>>> +     char *str;
>>> +
>>> +     if (generate_random_buffer(irk, 16)) {
>>> +             error("Failed to generate IRK");
>>> +             return -1;
>>> +     }
>>> +
>>> +     for (i = 0; i < 16; i++)
>>> +             sprintf(str_irk_out + (i * 2), "%02x", irk[i]);
>>> +
>>> +     str_irk_out[32] = '\0';
>>> +     info("Generated IRK successfully");
>>> +
>>> +     g_key_file_set_string(key_file, "Keys", "IRK", str_irk_out);
>> 
>> I think we opted to always use the long names. So IdentityResolvingKey please. And of course this needs to be documented in doc/settings-format.txt as well.
>> 
>> In addition I would combine these under [Identity] since besides the IRK itself, this might have the choice between using the Public Address or a generated Static Random Address that we have to store as well.
>> 
>>> +     str = g_key_file_to_data(key_file, &length, NULL);
>>> +     g_file_set_contents(filename, str, length, NULL);
>>> +     g_free(str);
>>> +     DBG("Generated IRK written to file");
>>> +     return 0;
>>> +}
>>> +
>>> +static int load_irk(struct btd_adapter *adapter, uint8_t *irk)
>>> +{
>>> +     GKeyFile *key_file;
>>> +     char filename[PATH_MAX];
>>> +     char address[18];
>>> +     char *str_irk;
>>> +     int ret;
>>> +
>>> +     ba2str(&adapter->bdaddr, address);
>>> +     snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
>>> +
>>> +     key_file = g_key_file_new();
>>> +     g_key_file_load_from_file(key_file, filename, 0, NULL);
>>> +
>>> +     str_irk = g_key_file_get_string(key_file, "Keys", "IRK", NULL);
>>> +     if (!str_irk) {
>>> +             info("No IRK for %s, creating new IRK", address);
>>> +             ret = generate_and_write_irk(irk, key_file, filename);
>>> +             g_key_file_free(key_file);
>>> +             return ret;
>>> +     }
>>> +
>>> +     g_key_file_free(key_file);
>>> +
>>> +     if (strlen(str_irk) != 32 || str2buf(str_irk, irk, 16)) {
>>> +             /* TODO re-create new IRK here? */
>>> +             error("Invalid IRK format, not enabling privacy");
>>> +             g_free(str_irk);
>>> +             return -1;
>>> +     }
>>> +
>>> +     g_free(str_irk);
>>> +     DBG("Successfully read IRK from file");
>>> +     return 0;
>>> +}
>>> +
>>> +static void set_privacy_complete(uint8_t status, uint16_t length,
>>> +                                     const void *param, void *user_data)
>>> +{
>>> +     struct btd_adapter *adapter = user_data;
>>> +
>>> +     if (status != MGMT_STATUS_SUCCESS) {
>>> +             btd_error(adapter->dev_id, "Failed to set privacy: %s (0x%02x)",
>>> +                                             mgmt_errstr(status), status);
>>> +             return;
>>> +     }
>>> +
>>> +     DBG("Successfuly set privacy for index %u", adapter->dev_id);
>>> +}
>>> +
>>> +static int set_privacy(struct btd_adapter *adapter)
>>> +{
>>> +     struct mgmt_cp_set_privacy cp;
>>> +     int err;
>>> +
>>> +     memset(&cp, 0, sizeof(cp));
>>> +     /* TODO privacy mode should be configured from main.conf */
>> 
>> Yes, the main.conf should get a Privacy option (which defaults to off). And in addition the settings file might override it individually per controller.
> 
> How that would be controlled per adapter? Via D-Bus prop? Or if
> controller mgmt settings
> changed we remember it in settings?

I have honestly no idea what is the best way to control that setting per controller. Remember that we have an erratum that introduces the differences between network and device security. That is something we also need to account for and also support in the kernel as Privacy 0x02.

Maybe this is something that should only be allowed via a plugin to configure. Maybe the plugin should be able to provide the public address and identity address and with that also the IRK.

This would almost go into the direction to allow for a %s/identity file that stores this information. Which then means that we also allow for re-programming the public address. Which some controllers have support for. And would be an interesting feature to add. Or just plain and simple use the static random address as identity address.

For example I could imagine it being useful to have some sort of plugin interface that allows for requesting the identity information (and these then could be stored in some OTP memory). I certainly see that the IRK might be part of this.

Anyway, this might be all good for future improvements. I think first we need to decide where to store the key. And with that all said, we might want to pick %s/identity or %s/secrets or %s/keys so that a migration becomes a lot easier in the future to whatever we decide. And go with a simple main.conf global configuration for all of these.

Regards

Marcel

