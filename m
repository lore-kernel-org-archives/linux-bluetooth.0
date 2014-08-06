Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000001cfb169$e4d01bc0$ae705340$@samsung.com>
References: <000001cfb169$e4d01bc0$ae705340$@samsung.com>
Date: Wed, 6 Aug 2014 15:02:49 +0300
Message-ID: <CABBYNZKTc7DYz5OSJOYm8uTDRzOOzfLMaOPGg-U7TTneaRiH_A@mail.gmail.com>
Subject: Re: Query regarding MAP 1.2 implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 6, 2014 at 2:30 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi All,
>
> I am currently working on MAP implementation in BlueZ.
> I am trying below things to make MAS connect with remote MCE client.
>
> Below are the steps we followed;
>
> On MCE device:
> --> MAS search
> --> MAS connect
> --> SET PATH (/)
>
> On Bluez, obexd:
> --> Run "bluetoothd"
> --> Run "obexd"
> --> On SET_PATH command it sends the obex session value as NULL.
>
>
> obexd[32713]: obexd/plugins/bluetooth.c:profile_new_connection() device
> /org/bluez/hci0/dev_00_1B_DC_07_33_4E
> obexd[32713]: obexd/src/obex.c:obex_session_start()
> obexd[32713]: obexd/src/obex.c:cmd_connect()
> obexd[32713]: CONNECT(0x0), (null)(0xffffffff)
> obexd[32713]: obexd/src/obex.c:cmd_connect() Selected driver: Message Access
> server
> obexd[32713]: obexd/plugins/mas.c:mas_connect()
> obexd[32713]: CONNECT(0x0), (null)(0x0)
> obexd[32713]: obexd/src/obex.c:cmd_setpath()
> obexd[32713]: obexd/src/obex.c:cmd_setpath() (null)
> obexd[32713]: SETPATH(0x5), (null)(0xffffffff)
> obexd[32713]: obexd/src/obex.c:parse_name() NAME:
> obexd[32713]: obexd/plugins/mas.c:mas_setpath() SETPATH: name  nonhdr 0x20
> obexd[32713]: SETPATH(0x5), NOT_FOUND(0x44)
>
> Do we need to configure or run anything else before starting up obexd?

You are probably missing a backend implementation for your message
database, currently we are building with dummy as backend but the idea
is that we switch to a runtime solution probably we a D-Bus agent
interface to interact with these requests using a file descriptor to
optimize the data transfer. iirc samsung has done a D-Bus backend for
BlueZ 4 in Tizen perhaps you can star by looking what kind of
interface is there.


-- 
Luiz Augusto von Dentz
