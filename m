Return-Path: <szymon.janc@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <772531BA-59CA-44E3-B8F1-DEA3FD64C2FF@holtmann.org>
References: <1470052433-21116-1-git-send-email-michal.narajowski@codecoup.pl> <772531BA-59CA-44E3-B8F1-DEA3FD64C2FF@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Tue, 2 Aug 2016 10:04:20 +0200
Message-ID: <CAAEJBhKMfYQHA-o+RmnwWJv+PQ=K4=jLEDqZKYHo5TjCJOrb-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/adapter: Add support for enabling privacy
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 1 August 2016 at 15:15, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Michal,
>
>> This adds support for loading local IRK key when adapter is configured.
>> In case IRK is not present new key is generated and stored.
>> ---
>> src/adapter.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>> 1 file changed, 136 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 3742398..fc8d10c 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -433,6 +433,12 @@ static void store_adapter_info(struct btd_adapter *=
adapter)
>>
>>       key_file =3D g_key_file_new();
>>
>> +     ba2str(&adapter->bdaddr, address);
>> +     snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
>> +
>> +     /* IRK must be preserved in the file, so load contents first */
>> +     g_key_file_load_from_file(key_file, filename, 0, NULL);
>> +
>
> is this really needed? I mean, the IRK should be already present in memor=
y and synced to the settings file after its creation. Sounds to me like we =
are hacking around a bug here.

After loading IRK to kernel it is no longer needed. I told Micha=C5=82
(offline) not to keep IRK in
memory after loading it to kernel and just read settings before
storing. Yet, if you prefer
to just keep IRK in memory instead of reading file then I'm fine with it.

>
>>       if (adapter->pairable_timeout !=3D main_opts.pairto)
>>               g_key_file_set_integer(key_file, "General", "PairableTimeo=
ut",
>>                                       adapter->pairable_timeout);
>> @@ -455,11 +461,6 @@ static void store_adapter_info(struct btd_adapter *=
adapter)
>>               g_key_file_set_string(key_file, "General", "Alias",
>>                                                       adapter->stored_al=
ias);
>>
>> -     ba2str(&adapter->bdaddr, address);
>> -     snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
>> -
>> -     create_file(filename, S_IRUSR | S_IWUSR);
>> -
>>       str =3D g_key_file_to_data(key_file, &length, NULL);
>>       g_file_set_contents(filename, str, length, NULL);
>>       g_free(str);
>> @@ -3141,6 +3142,130 @@ static struct conn_param *get_conn_param(GKeyFil=
e *key_file, const char *peer,
>>       return param;
>> }
>>
>> +static int generate_random_buffer(uint8_t *buf, int buflen)
>> +{
>> +     int fd;
>> +
>> +     fd =3D open("/dev/urandom", O_RDONLY);
>> +     if (fd < 0) {
>> +             error("Error opening /dev/urandom: %s", strerror(errno));
>> +             return -1;
>> +     }
>> +
>> +     if (read(fd, buf, buflen) !=3D buflen) {
>> +             error("Reading from urandom failed");
>> +             close(fd);
>> +             return -1;
>> +     }
>> +
>> +     close(fd);
>> +     return 0;
>> +}
>
> Please use bt_crypto_random_bytes so that we eventually can move this tow=
ards the new system call or AF_ALG since opening manually /dev/urandom in m=
ultiple locations is a bad idea.
>
> I would not even mind creating bt_crypto_generate_irk for this simple pur=
pose.
>
>> +
>> +static int generate_and_write_irk(uint8_t *irk, GKeyFile *key_file, con=
st char *filename)
>> +{
>> +     char str_irk_out[33];
>> +     gsize length =3D 0;
>> +     int i;
>> +     char *str;
>> +
>> +     if (generate_random_buffer(irk, 16)) {
>> +             error("Failed to generate IRK");
>> +             return -1;
>> +     }
>> +
>> +     for (i =3D 0; i < 16; i++)
>> +             sprintf(str_irk_out + (i * 2), "%02x", irk[i]);
>> +
>> +     str_irk_out[32] =3D '\0';
>> +     info("Generated IRK successfully");
>> +
>> +     g_key_file_set_string(key_file, "Keys", "IRK", str_irk_out);
>
> I think we opted to always use the long names. So IdentityResolvingKey pl=
ease. And of course this needs to be documented in doc/settings-format.txt =
as well.
>
> In addition I would combine these under [Identity] since besides the IRK =
itself, this might have the choice between using the Public Address or a ge=
nerated Static Random Address that we have to store as well.
>
>> +     str =3D g_key_file_to_data(key_file, &length, NULL);
>> +     g_file_set_contents(filename, str, length, NULL);
>> +     g_free(str);
>> +     DBG("Generated IRK written to file");
>> +     return 0;
>> +}
>> +
>> +static int load_irk(struct btd_adapter *adapter, uint8_t *irk)
>> +{
>> +     GKeyFile *key_file;
>> +     char filename[PATH_MAX];
>> +     char address[18];
>> +     char *str_irk;
>> +     int ret;
>> +
>> +     ba2str(&adapter->bdaddr, address);
>> +     snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
>> +
>> +     key_file =3D g_key_file_new();
>> +     g_key_file_load_from_file(key_file, filename, 0, NULL);
>> +
>> +     str_irk =3D g_key_file_get_string(key_file, "Keys", "IRK", NULL);
>> +     if (!str_irk) {
>> +             info("No IRK for %s, creating new IRK", address);
>> +             ret =3D generate_and_write_irk(irk, key_file, filename);
>> +             g_key_file_free(key_file);
>> +             return ret;
>> +     }
>> +
>> +     g_key_file_free(key_file);
>> +
>> +     if (strlen(str_irk) !=3D 32 || str2buf(str_irk, irk, 16)) {
>> +             /* TODO re-create new IRK here? */
>> +             error("Invalid IRK format, not enabling privacy");
>> +             g_free(str_irk);
>> +             return -1;
>> +     }
>> +
>> +     g_free(str_irk);
>> +     DBG("Successfully read IRK from file");
>> +     return 0;
>> +}
>> +
>> +static void set_privacy_complete(uint8_t status, uint16_t length,
>> +                                     const void *param, void *user_data=
)
>> +{
>> +     struct btd_adapter *adapter =3D user_data;
>> +
>> +     if (status !=3D MGMT_STATUS_SUCCESS) {
>> +             btd_error(adapter->dev_id, "Failed to set privacy: %s (0x%=
02x)",
>> +                                             mgmt_errstr(status), statu=
s);
>> +             return;
>> +     }
>> +
>> +     DBG("Successfuly set privacy for index %u", adapter->dev_id);
>> +}
>> +
>> +static int set_privacy(struct btd_adapter *adapter)
>> +{
>> +     struct mgmt_cp_set_privacy cp;
>> +     int err;
>> +
>> +     memset(&cp, 0, sizeof(cp));
>> +     /* TODO privacy mode should be configured from main.conf */
>
> Yes, the main.conf should get a Privacy option (which defaults to off). A=
nd in addition the settings file might override it individually per control=
ler.

How that would be controlled per adapter? Via D-Bus prop? Or if
controller mgmt settings
changed we remember it in settings?

>
>> +     cp.privacy =3D 0x01;
>> +     err =3D load_irk(adapter, cp.irk);
>> +
>> +     /* TODO should we disable if IRK is invalid? */
>> +     if (err)
>> +             return err;
>
> Yes, if there is no IRK available, and we can not generate one, then we s=
hould not enable privacy. And in addition if privacy has already been enabl=
ed, we need to disable it.
>
>> +
>> +     DBG("sending set privacy command for index %u", adapter->dev_id);
>> +     DBG("setting privacy mode %u for index %u", cp.privacy, adapter->d=
ev_id);
>> +
>> +     if (mgmt_send(adapter->mgmt, MGMT_OP_SET_PRIVACY,
>> +                             adapter->dev_id, sizeof(cp), &cp,
>> +                             set_privacy_complete, adapter, NULL) > 0)
>> +             return 0;
>> +
>> +     btd_error(adapter->dev_id, "Failed to set privacy for index %u",
>> +                                                     adapter->dev_id);
>> +
>> +     return -1;
>> +}
>> +
>> static void load_link_keys_complete(uint8_t status, uint16_t length,
>>                                       const void *param, void *user_data=
)
>> {
>> @@ -7893,6 +8018,12 @@ static void read_info_complete(uint8_t status, ui=
nt16_t length,
>>       if (missing_settings & MGMT_SETTING_SECURE_CONN)
>>               set_mode(adapter, MGMT_OP_SET_SECURE_CONN, 0x01);
>>
>> +     /*
>> +      * Always reload privacy settings and set IRK.
>> +      */
>
> I don't like this comment. It has no meaning for me on what we are doing.=
 Either leave it out or explain exactly what is going on here.
>
>> +     if (adapter->supported_settings & MGMT_SETTING_PRIVACY)
>> +             set_privacy(adapter);
>> +
>
> I also wonder if this should have the main.conf checks here. Like we do w=
ith the others.
>
>>       if (main_opts.fast_conn &&
>>                       (missing_settings & MGMT_SETTING_FAST_CONNECTABLE)=
)
>>               set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
pozdrawiam
Szymon K. Janc
