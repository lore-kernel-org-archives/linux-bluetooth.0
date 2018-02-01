Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] tools/obexctl: Retrieve updated Size property
 once
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <93990bf7-f452-b47f-70c1-9370f2b860cd@jp.fujitsu.com>
 <CABBYNZ+3YU-=zAujpmt=Ykq_7Hr5WxBn5Jkn3dLqEeV8QYK1kg@mail.gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <d3b8d017-a2ab-b423-652f-dfdcc3855c90@jp.fujitsu.com>
Date: Thu, 1 Feb 2018 11:59:07 +0900
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+3YU-=zAujpmt=Ykq_7Hr5WxBn5Jkn3dLqEeV8QYK1kg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 01/31/2018 08:35 PM, Luiz Augusto von Dentz wrote:
> Hi Eramoto,
> 
> On Fri, Jan 26, 2018 at 6:14 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> Since obexd may have updated the Size property, obexctl retrieves it
>> once so that it can output more proper transfer information.
>> ---
>>  tools/obexctl.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/obexctl.c b/tools/obexctl.c
>> index 05bbd3e84..777221d2f 100644
>> --- a/tools/obexctl.c
>> +++ b/tools/obexctl.c
>> @@ -1888,6 +1888,13 @@ static void transfer_property_changed(GDBusProxy *proxy, const char *name,
>>         str = proxy_description(proxy, "Transfer", COLORED_CHG);
>>
>>         if (strcmp(name, "Transferred") == 0) {
>> +               /*
>> +                * Since the Size property may have been updated at the start
>> +                * of the transfer, it is retrieved so that the transfer
>> +                * information can be output more proper.
>> +                */
>> +               if (data->transferred == 0)
>> +                       g_dbus_proxy_refresh_property(proxy, "Size");
> 
> Usually we don't have to refresh property manually like this, so I
> wonder if there is something else going on, perhaps the daemon is not
> emitting PropertiesChanged when it should.
> 

The Size property is "optional" in doc/obex-api.txt, so I thought:
  * obexd daemon can choose whether or not to emit the property,
  * and an app (e.g. obexctl) needs to refresh it if wants to 
    retrieve it.
Are the above things mistake?

Does "optional" mean that:
  * obexd daemon can choose whether or not to provide the property,
  * and obexd daemon should emit the property with a proper/valid
    value if it exists (i.e. if obexd daemon provides it)?


Regards,
Eramoto

>>                 print_transferred(data, str, iter);
>>                 goto done;
>>         }
>> --
>> 2.14.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

