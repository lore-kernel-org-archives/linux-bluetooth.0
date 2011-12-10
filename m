Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKOw4fkKamx0sYqm-T9LuBJw8CmsXjapVkSKKUwtbFTgg@mail.gmail.com>
References: <CAG5tN=VUkkRz9UE72F_wHeypeBVnOUfVcrTeamLg6hERPL4Nyg@mail.gmail.com>
	<CAG5tN=XsnPsm7xWv=LgLeAUGEBfzspiQUYBgTqcEyXGMgeMYAg@mail.gmail.com>
	<CABBYNZKOw4fkKamx0sYqm-T9LuBJw8CmsXjapVkSKKUwtbFTgg@mail.gmail.com>
Date: Sat, 10 Dec 2011 07:24:38 +0100
Message-ID: <CAG5tN=UtJwc_HvTEB0aJje3isUF+wGwmxxPk+85xL7E3SVXrXg@mail.gmail.com>
Subject: Re: Problems connecting Logitech Bluetooth headset
From: Luciana Souza <lucianamssouza@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you for the hint.

I have followed your advice and used the hcidump -X command. This is what I get:

< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 37 voice setting 0x0060 ptype 0x003f
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 37 slots 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x20 handle 37 bdaddr 00:0D:44:A5:8C:E2 type eSCO
    Error: Unsupported LMP Parameter Value
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 37 slots 5

I must admit that I do not understand what this means. But I do
understand that there is an error:
" Error: Unsupported LMP Parameter Value"

Any ideas of what I could do next?


On Mon, Nov 21, 2011 at 12:21 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Luciana,
>
> On Mon, Nov 21, 2011 at 12:44 PM, Luciana Souza
> <lucianamssouza@gmail.com> wrote:
>> Dear list,
>>
>> Does anyone have an idea of what could be the source of the problem I
>> described below?
>>
>> Thanks in advance!
>> Luciana
>>
>> On Sun, Nov 20, 2011 at 8:04 PM, Luciana Souza <lucianamssouza@gmail.com> wrote:
>>> Hello everyone,
>>>
>>> I hope someone can help me find out what could possibly be wrong with my system.
>>>
>>> I am trying to get my new Logitech bluetooth headset to work
>>> http://www.logitech.com/en-ch/tablet-accessories/for-ipad/devices/8452
>>>
>>> I am facing several problems, to get it work.
>>>
>>> Some info:
>>> moreira@WS-LSO3:~$ uname -a
>>> Linux WS-LSO3 3.0.0-12-generic #20-Ubuntu SMP Fri Oct 7 14:56:25 UTC
>>> 2011 x86_64 x86_64 x86_64 GNU/Linux
>>> moreira@WS-LSO3:~$ lsb_release -a
>>> No LSB modules are available.
>>> Distributor ID:    Ubuntu
>>> Description:    Ubuntu 11.10
>>> Release:    11.10
>>> Codename:    oneiric
>>>
>>> I have put the bluetoothd and the pulseaudio to verbose the output.
>>> This is what I am getting after pairing:
>>>
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: audio/unix.c:server_cb()
>>> Accepted new client connection on unix socket (fd=30)
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: audio/unix.c:client_cb()
>>> Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE ->
>>> BT_GET_CAPABILITIES
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: audio/unix.c:client_cb()
>>> Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE ->
>>> BT_GET_CAPABILITIES
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: audio/unix.c:client_cb()
>>> Audio API: BT_REQUEST <- BT_OPEN
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/unix.c:handle_sco_open() open sco -
>>> object=/org/bluez/3606/hci0/dev_00_0D_44_A5_8C_E2 source=ANY
>>> destination=ANY lock=readwrite
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_OPEN
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: audio/unix.c:client_cb()
>>> Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE ->
>>> BT_SET_CONFIGURATION
>>> Nov 20 11:58:40 WS-LSO3 rtkit-daemon[1296]: Successfully made thread
>>> 3628 of process 3301 (n/a) owned by '1000' RT at priority 5.
>>> Nov 20 11:58:40 WS-LSO3 rtkit-daemon[1296]: Supervising 4 threads of 1
>>> processes of 1 users.
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: audio/unix.c:client_cb()
>>> Audio API: BT_REQUEST <- BT_START_STREAM
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/headset.c:headset_set_state() State changed
>>> /org/bluez/3606/hci0/dev_00_0D_44_A5_8C_E2: HEADSET_STATE_CONNECTED ->
>>> HEADSET_STATE_PLAY_IN_PROGRESS
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: Operation not supported (95)
>
> I suspect this error above will cause PulseAudio to unload/remove the card.
>
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: headset_resume_complete: resume failed
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/unix.c:unix_ipc_error() sending error Input/output error(5)
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/unix.c:unix_ipc_sendmsg() Audio API: BT_ERROR -> BT_START_STREAM
>>> Nov 20 12:58:40 WS-LSO3 pulseaudio[3301]: [bluetooth]
>>> module-bluetooth-device.c: Received error condition: Input/output
>>> error
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]:
>>> audio/headset.c:headset_set_state() State changed
>>> /org/bluez/3606/hci0/dev_00_0D_44_A5_8C_E2:
>>> HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: audio/unix.c:client_cb()
>>> Unix client disconnected (fd=30)
>>> Nov 20 12:58:40 WS-LSO3 bluetoothd[3606]: audio/unix.c:client_free()
>>> client_free(0x7f830f181120)
>>>
>>> Even though the headset is added to the list of paired items, it is
>>> not possible to use it right away. This is probably because of the
>>> "Operation not supported" error.
>
> Yep
>
>>> Can anyone give me a hint of what I could possibly be doing wrong?
>
> It could be that your local adapter has some problem with SCO
> connections, so perhaps if you try another adapter? If that is not
> possible you can try running hcidump -X to see what is going on HCI
> level.
>
> --
> Luiz Augusto von Dentz
