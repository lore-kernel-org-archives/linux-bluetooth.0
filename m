Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKHsmFqKO9ZnOkhTyWytvQE7qOKe3vVV=DqCWoRMfifJLS-LnQ@mail.gmail.com>
References: <1488235227-27632-1-git-send-email-juha.kuikka@synapse.com>
 <1488235227-27632-2-git-send-email-juha.kuikka@synapse.com>
 <CAGXr9JG_dKSjD31DW5=0TH5Y9YD_oFdpQ6t-MTek_2hCd7GzNg@mail.gmail.com> <CAKHsmFqKO9ZnOkhTyWytvQE7qOKe3vVV=DqCWoRMfifJLS-LnQ@mail.gmail.com>
From: Petri Gynther <pgynther@google.com>
Date: Tue, 28 Feb 2017 16:23:58 -0800
Message-ID: <CAGXr9JFe7G0-ca-Vh86hu3Gfj=_-oXMBek-SMwzU-Rjm_MNMuA@mail.gmail.com>
Subject: Re: [PATCH] hog: Destroy uHID device when disconnected
To: Juha Kuikka <juha.kuikka@synapse.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Juha Kuikka <juha.kuikka@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

On Tue, Feb 28, 2017 at 4:01 PM, Juha Kuikka <juha.kuikka@synapse.com> wrote:
> Hi Petry,
>
> On Mon, Feb 27, 2017 at 6:17 PM, Petri Gynther <pgynther@google.com> wrote:
>> Hi Juha,
>>
>> On Mon, Feb 27, 2017 at 2:40 PM, Juha Kuikka <juha.kuikka@synapse.com> wrote:
>>>
>>> Unlink bluetooth classic HID, HoG persists the uHID device after across
>>> connections. This is fine for stateless devices but some device utilize hidraw
>>> to configure them upon connection and with the persisting uHID device,
>>> reconnections are hidden from them.
>>>
>>> Similarly, applications such as game emulators may be using the presence of the
>>> HID or the accompanying input event devices to indicate that it is available,
>>> thus changing behavior.
>>>
>>> This patch destroys the uHID device upon disconnection, it gets re-created upon
>>> reconnection, just like on initial connection.
>>
>> For HID and HoG remote controls, the reconnect latency is important
>> for user experience. Thus, it is desirable that the uHID device is
>> persistent across reconnects until next reboot.
>
> I see. That makes sense, this way the whole pipeline is guaranteed to
> be already open when the connection forms, leading to less dropped
> button presses I suppose.
>

Correct.

>> How about adding a new config item to profiles/input/input.conf to
>> control this (default = persistent uHID devices)?
>
> Works for me. Something like this maybe? Excuse the quick patch, I
> will send a revision to the set.
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index f41055b..2b954b3 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -129,6 +129,13 @@ struct gatt_request {
>         void *user_data;
>  };
>
> +static bool persist_uhid = true;
> +
> +void bt_hog_set_persist_uhid(bool state)
> +{
> +       persist_uhid = state;
> +}
> +
>  static struct gatt_request *create_request(struct bt_hog *hog,
>                                                         void *user_data)
>  {
> diff --git a/profiles/input/hog-lib.h b/profiles/input/hog-lib.h
> index 415dc63..7e81547 100644
> --- a/profiles/input/hog-lib.h
> +++ b/profiles/input/hog-lib.h
> @@ -39,3 +39,4 @@ void bt_hog_detach(struct bt_hog *hog);
>
>  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
>  int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type);
> +void bt_hog_set_persist_uhid(bool state);
> diff --git a/profiles/input/manager.c b/profiles/input/manager.c
> index 1d31b06..129b7b5 100644
> --- a/profiles/input/manager.c
> +++ b/profiles/input/manager.c
> @@ -43,6 +43,8 @@
>  #include "device.h"
>  #include "server.h"
>
> +#include "profiles/input/hog-lib.h"
> +
>  static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
>  {
>         return server_start(btd_adapter_get_address(adapter));
> @@ -96,7 +98,7 @@ static int input_init(void)
>         config = load_config_file(CONFIGDIR "/input.conf");
>         if (config) {
>                 int idle_timeout;
> -               gboolean uhid_enabled;
> +               gboolean uhid_enabled, persist_uhid;
>
>                 idle_timeout = g_key_file_get_integer(config, "General",
>                                                         "IdleTimeout", &err);
> @@ -114,6 +116,15 @@ static int input_init(void)
>                         input_enable_userspace_hid(uhid_enabled);
>                 } else
>                         g_clear_error(&err);
> +
> +               persist_uhid = g_key_file_get_boolean(config, "General",
> +                                                       "PersistUHID", &err);
> +               if (!err) {
> +                       DBG("input.conf: PersistUHID=%s", persist_uhid ?
> +                                                       "true" : "false");
> +                       bt_hog_set_persist_uhid(persist_uhid);
> +               } else
> +                       g_clear_error(&err);
>         }
>
>         btd_profile_register(&input_profile);
>
> Thanks,
>  - Juha

I would prefer to use UHIDDestroy (which will be false by default).
Please add this to your patch:

diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index 3e1d65aae..4a93e4220 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -11,3 +11,7 @@
 # Enable HID protocol handling in userspace input profile
 # Defaults to false (HIDP handled in HIDP kernel module)
 #UserspaceHID=true
+
+# Destroy uHID device on HID/HoG disconnect
+# Defaults to false (uHID device is persistent across reconnects)
+#UHIDDestroy=true
