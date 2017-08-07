Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yunhanw@nestlabs.com
In-Reply-To: <CALvjcs_0DMU=hFD6FvK+r2i26bx+Zx66+dkxWhUsjGFkpdAS8Q@mail.gmail.com>
References: <CALvjcs88qDooFW-L1ANXoNrp9KKwXHh+_NaLLzKhbOQvMDLcTQ@mail.gmail.com>
 <CABBYNZLfE59FjTj4Y0G69qWFNKcYxD=vA2sRyQhQWM4AJSV3bg@mail.gmail.com>
 <CALvjcs_QZDkutN88Z5Ve5_efyh68k7FJS_-nj+YCr-h=1BJD5A@mail.gmail.com>
 <CABBYNZJ2mcjy8+LfA51RyqvYRRK7_R=d-xNFusqKUbTnNtwaxg@mail.gmail.com> <CALvjcs_0DMU=hFD6FvK+r2i26bx+Zx66+dkxWhUsjGFkpdAS8Q@mail.gmail.com>
From: Yunhan Wang <yunhanw@nestlabs.com>
Date: Mon, 7 Aug 2017 13:15:41 -0700
Message-ID: <CALvjcs9MO-7o3VEXOvmTxXj6LWMYF2s7e6C7C4xD0EMdqCZumg@mail.gmail.com>
Subject: Re: bluetoothctl: how to send notification/indcation from peripheral
 to central
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

Please see the below comment reply.

Thank you
Best wishes
Yunhan
On Mon, Aug 7, 2017 at 11:49 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
>
> Hi, Luiz
>
> This is complete diff I am currently playing.
>
> diff --git a/client/gatt.c b/client/gatt.c
> index bd6e6b0af..548c798a2 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -1449,16 +1449,27 @@ static uint8_t *str2bytearray(char *arg, int *val_len)
>         return g_memdup(value, i);
>  }
>
> -static void chrc_set_value(const char *input, void *user_data)
> +void chrc_set_value(const char *input, void *user_data)
>  {
>         struct chrc *chrc = user_data;
>
>         g_free(chrc->value);
>
>         chrc->value = str2bytearray((char *) input, &chrc->value_len);
> +
>  }
>
> -void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
> +void chrc_set_value1(const char *input, void *user_data, DBusConnection *conn)
> +{
> +    struct chrc *chrc = user_data;
> +
> +    g_free(chrc->value);
> +
> +    chrc->value = str2bytearray((char *) input, &chrc->value_len);
> +    g_dbus_emit_property_changed(conn, chrc->path, "org.bluez.GattCharacteristic1", "Value");
> +
> +}

@Luiz, here i am using g_dbus_emit_property_changed, which should
further call process_properties_from_interface, but I cannot see the
value change has been sent from peripheral to central automatically,
anything I am missing?

>
> +struct chrc * gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
>  {
>         struct service *service;
>         struct chrc *chrc;
> @@ -1489,6 +1500,8 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
>         print_chrc(chrc, COLORED_NEW);
>
>         rl_prompt_input(chrc->path, "Enter value:", chrc_set_value, chrc);
> +
> +    return chrc;
>  }
>
>  static struct chrc *chrc_find(const char *pattern)
> diff --git a/client/gatt.h b/client/gatt.h
> index 9bab42902..bddba40e4 100644
> --- a/client/gatt.h
> +++ b/client/gatt.h
> @@ -55,10 +55,11 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
>  void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
>                                                                 wordexp_t *w);
>
> -void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
> +struct chrc * gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
>  void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
>                                                                 wordexp_t *w);
>
>  void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
>  void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
>                                                                 wordexp_t *w);
> +void chrc_set_value1(const char *input, void *user_data, DBusConnection *conn);
> \ No newline at end of file
> diff --git a/client/main.c b/client/main.c
> index 40075f27e..6c5ae231d 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -78,7 +78,7 @@ static GList *ctrl_list;
>  static GList *ad_manager_list;
>  static guint input = 0;
>  static char * adapter_address;
> -
> +struct chrc * default_chrc;
>  static const char * const agent_arguments[] = {
>         "on",
>         "off",
> @@ -2147,12 +2147,18 @@ static void cmd_register_characteristic(const char *arg)
>                 goto done;
>         }
>
> -       gatt_register_chrc(dbus_conn, default_ctrl->proxy, &w);
> +    default_chrc = gatt_register_chrc(dbus_conn, default_ctrl->proxy, &w);
>
>  done:
>         wordfree(&w);
>  }

@Luiz, here I am testing only one characteristic, and  storing the
default chrc in global variable.

>
>
> +static void cmd_update_chrc(const char *arg)
> +{
> +    chrc_set_value1(arg, default_chrc, dbus_conn);
> +
> +}
> +
>  static void cmd_unregister_characteristic(const char *arg)
>  {
>         wordexp_t w;
> @@ -2541,6 +2547,9 @@ static const struct {
>         { "register-characteristic", "<UUID> <Flags=read,write,notify...>",
>                                         cmd_register_characteristic,
>                                         "Register application characteristic" },
> +    { "update-chrc", "<value>",
> +            cmd_update_chrc,
> +            "update chrc value" },
>         { "unregister-characteristic", "<UUID/object>",
>                                 cmd_unregister_characteristic,
>                                 "Unregister application characteristic" },
>
>
> On Mon, Aug 7, 2017 at 6:15 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Yunhan,
>>
>> On Mon, Aug 7, 2017 at 2:29 PM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
>> > Hi Luiz
>> >
>> > Thanks for your reply. Do you know how to generate PropertiesChanged
>> > signal after updating 'Value' successfully using C , which
>> > API/function should I use/try?
>>
>> It depends on what binding/library are you using, with libdbus:
>>
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/object.c#n1654
>>
>> Which is the code that called if you do  g_dbus_emit_property_changed.
>>
>> > Thanks
>> > Best wishes
>> > Yunhan
>> >
>> > On Mon, Aug 7, 2017 at 2:52 AM, Luiz Augusto von Dentz
>> > <luiz.dentz@gmail.com> wrote:
>> >> Hi Yunhan
>> >>
>> >> On Mon, Aug 7, 2017 at 9:18 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
>> >>> Hi Luiz,
>> >>>
>> >>>Do you have any idea about this issue?
>> >>>
>> >>> Best wishes
>> >>> Yunhan
>> >>>
>> >>> On Sun, Aug 6, 2017 at 1:25 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
>> >>>> Hi
>> >>>>
>> >>>> Has any one been able to send notification from LE peripheral to LE
>> >>>> central using bluetoothctl?
>> >>>>
>> >>>> Now I am trying to update "Value" with 0x02 for the below
>> >>>> characteristic with read and indicate flag, i am expecting a
>> >>>> notification can be sent from peripheral to central automatically. It
>> >>>>seems there is no such support in bluetoothctl.Then I do simple code
>> >>>> change on below, and try to update value via "update-chrc 0x02", well,
>> >>>> the value has been successfully updated, but there is no
>> >>>> message/notification sent from peripheral to central automatically. I
>> >>>> have confirmed that chrc read from central is showing updated value,
>> >>>> 02, correctly. The question is that how can we send characteristic
>> >>>> notification/indication using bluez dbus API?
>> >>
>> >> That is up for the application when to generate Value changes, we can
>> >> introduce a command to just do that, though using bluetoothctl to
>> >> generate notification is not very user friendly.
>> >>
>> >> bluetoothd will notice if the application had update its Value, but in
>> >> order for this to work you have to generate the PropertiesChanged
>> >> signal.
>> >>
>> >>>> btw, I see the video(BlueZ Meets Zephyr made by Luiz)
>> >>>> https://www.youtube.com/watch?v=SdmZX5q-XDg
>> >>>> In 30:05,I see Zephyr is sending notification to bluetoothctl
>> >>>> automatically.How can we just use bluez dbus API to achieve this?
>> >>
>> >> That is using HRS and emulating the heart rate measurements.
>> >>
>> >>>> for example,
>> >>>> In LE peripheral:
>> >>>>I setup the below characteristic with read and indicate flag
>> >>>> register-service 00001820-0000-1000-8000-00805f9b34fb
>> >>>> register-characteristic 00002a06-0000-1000-8000-00805f9b34fb read,indicate
>> >>>> register-application
>> >>>> advertise peripheral
>> >>>>
>> >>>> In LE central:
>> >>>> connect 00:AA:01:00:00:23
>> >>>> select-attribute /org/bluez/hci1/dev_00_AA_01_00_00_23/service000a/char000b
>> >>>> notify on
>> >>>>
>> >>>> The code change snippet
>> >>>> --- a/client/gatt.c
>> >>>> +++ b/client/gatt.c
>> >>>>-void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
>> >>>> +void chrc_set_value1(const char *input, void *user_data, DBusConnection *conn)
>> >>>> +{
>> >>>> +    struct chrc *chrc = user_data;
>> >>>> +
>> >>>> +    g_free(chrc->value);
>> >>>> +
>> >>>> +    chrc->value = str2bytearray((char *) input, &chrc->value_len);
>> >>>> +    g_dbus_emit_property_changed(conn, chrc->path,
>> >>>> "org.bluez.GattCharacteristic1", "Value");
>> >>>> +
>> >>>> +}
>> >>>> +struct chrc * gatt_register_chrc(DBusConnection *conn, GDBusProxy
>> >>>> *proxy, wordexp_t *w)
>> >>>>  {
>> >>>>        struct service *service;
>> >>>>         struct chrc *chrc;
>> >>>> @@ -1489,6 +1500,8 @@ void gatt_register_chrc(DBusConnection *conn,
>> >>>> GDBusProxy *proxy, wordexp_t *w)
>> >>>>         print_chrc(chrc, COLORED_NEW);
>> >>>>
>> >>>>         rl_prompt_input(chrc->path, "Enter value:", chrc_set_value, chrc);
>> >>>> +
>> >>>> +    return chrc;
>> >>>>  }
>> >>>>
>> >>>> --- a/client/main.c
>> >>>> +++ b/client/main.c
>> >>>>+static void cmd_update_chrc(const char *arg)
>> >>>> +{
>> >>>> +    chrc_set_value1(arg, default_chrc, dbus_conn);
>> >>
>> >> Where does default_chrc comes from? I guess we would need some way to
>> >> select the server attributes in order to update them, again this is
>> >> not going to be user friendly since you have to send the notification
>> >> one by one. Perhaps an easier way to test this is to register standard
>> >>attributes like HRS and enable simulation, so it would act exactly
>> >> like zephyr or out example-gatt-server.
>> >>
>> >> This could perhaps be done automatically in case a know service is
>> >> registered without any attributes, e.g: HRS, then by the time we
>> >> register the application bluetoothctl would take care of registering
>> >> the standard attributes for the service.
>> >>
>> >>>> +
>> >>>> +}
>> >>>> +
>> >>>> static void cmd_unregister_characteristic(const char *arg)
>> >>>>  {
>> >>>>         wordexp_t w;
>> >>>> @@ -2541,6 +2547,9 @@ static const struct {
>> >>>>         { "register-characteristic", "<UUID> <Flags=read,write,notify...>",
>> >>>>                                         cmd_register_characteristic,
>> >>>>                                         "Register application characteristic" },
>> >>>> +    { "update-chrc", "<value.>",
>> >>>> +            cmd_update_chrc,
>> >>>> +            "update chrc value" },
>> >>>>
>> >>>> Thanks
>> >>>> Best wishes
>> >>>> Yunhan
>> >>> --
>> >>>To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> >>>the body of a message to majordomo@vger.kernel.org
>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>> >>
>> >> --
>> >>Luiz Augusto of Dentz Luiz Augusto of Dentz
>>
>>
>>
>> -
>
>
