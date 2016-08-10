Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj0YytBJw6Amp8y4=HgZMhVB2n+sbh866TNTSsB==-Dfn0AUQ@mail.gmail.com>
References: <CAMj0Yyv0LEjLSspsMP7MosNGbah376ncaY0Jmw6RR=41gVB4EA@mail.gmail.com>
 <CAMj0YytBJw6Amp8y4=HgZMhVB2n+sbh866TNTSsB==-Dfn0AUQ@mail.gmail.com>
From: Ajay Parashar <ajay.parasha@gmail.com>
Date: Wed, 10 Aug 2016 16:52:19 +0530
Message-ID: <CAMj0YyuCwA7BOy1rwHwX1VHGnvOkDYNBXJxUKfXfHN2HV5c8_g@mail.gmail.com>
Subject: Re: Connect method of org.bluez.Network1 interface throws error
 "Connect with signature "s" doesn't exist"
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 10, 2016 at 12:11 PM, Ajay Parashar <ajay.parasha@gmail.com> wrote:
> On Wed, Aug 3, 2016 at 3:44 PM, Ajay Parashar <ajay.parasha@gmail.com> wrote:
>> Hi,
>>
>> I am using bluez 5.35 and developing an application using Glib DBUS binding.
>>
>> As per network-api.txt documentation, my code calls connect API with
>> String type parameter but while execution it prompts below error.
>> Can you please let me know why is it giving this error and how can i
>> resolve this.
>>
>> //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> Unable to connect with network :
>> GDBus.Error:org.freedesktop.DBus.Error.UnknownObject: Method "Connect"
>> with signature "s" on interface "org.bluez.Network1" doesn't exist
>> ////////////////////////////////////////////////////////////////////////////////////////////////////////////
>>
>> /* For reference please find my code as below*/
>>
>> int connect_network(char *interface)
>> {
>>   int       ret       = 0;
>>   GError   *error     = NULL;
>>   GVariant *reply     = NULL;
>>
>>   GVariant **t = NULL;
>>   t    = g_new(GVariant *, 1);
>>   t[0] = g_variant_new_string ("nap");
>>
>>   GVariant *tuple_variant = g_variant_new_tuple(t, 1);
>>
>>   /* connect with network */
>>   reply = g_dbus_connection_call_sync(dbus_conn,
>>     BLUEZ_BUS_NAME,
>>     "/org/bluez/hci0",
>>     "org.bluez.Network1",
>>     "Connect",
>>     tuple_variant,
>>     G_VARIANT_TYPE_STRING,
>>     G_DBUS_CALL_FLAGS_NONE,
>>     -1,
>>     NULL,
>>     &error);
>>
>> if (error) {
>>     printf("Unable to connect with network : %s\n", error->message);
>> g_free(t);
>>     return -3;
>>   }
>>
>>    g_variant_get(reply, "(s)", &interface);
>>    printf("interface from connect is = %s\n", interface);
>>   g_free(t);
>>
>>   return ret;
>> }
>
>
> I am facing the same issue when i executed test-network program
> available with  /bluez-5.35/test directory.
> I m blocked here, please let me know how to proceed with bluez?
>
> Regards
> Ajay

Hi,

I experiment this issue with two different machines, issue still persists.
Please let me know how can i unblock from this issue, i will be
thankful you guys.
Let me explain the steps followed.
On Machine 1
Step 1)
# hciconfig
hci1: Type: BR/EDR  Bus: USB
BD Address: 00:1A:7D:DA:71:05  ACL MTU: 310:10  SCO MTU: 64:8
UP RUNNING PSCAN ISCAN INQUIRY
\RX bytes:43793 acl:12 sco:0 events:353 errors:0
TX bytes:2641 acl:11 sco:0 commands:130 errors:0

Step 2)
create a bridge using brctl commands and it is very much visible and
verified the same by ifconfig command.
# ifconfig
br0       Link encap:Ethernet  HWaddr b6:a3:07:14:05:73
          inet addr:10.0.10.1  Bcast:0.0.0.0  Mask:255.255.255.0
          inet6 addr: fe80::b4a3:7ff:fe14:573/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:215 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:22135 (22.1 KB)

Step 3)
paired this controller successfully with other BT controller that is
associated with machine 2

Step 4)
verified pair status from both machines.

Step 5)
execute the test-nap program

./test-nap br0

Server for nap registered for br0
Press CTRL-C to disconnect

step 6)
On machine 2  verify that controller is working by hciconfig command
# hciconfig
hci0: Type: BR/EDR  Bus: USB
BD Address: 00:1A:7D:DA:71:07  ACL MTU: 310:10  SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:1488 acl:12 sco:0 events:83 errors:0
TX bytes:3609 acl:13 sco:0 commands:56 errors:0

step 7)
On machine 2 execute test-network program
./test-network 00:1A:7D:DA:71:05 nap

Traceback (most recent call last):
  File "./test-network", line 48, in <module>
    iface = network.Connect(service)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
651, in call_blocking
    message, timeout)
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with
signature "s" on interface "org.bluez.Network1" doesn't exist


Regards
Ajay
