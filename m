Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <51890AC9.7010501@asianux.com>
References: <518906A8.7060708@asianux.com>
	<51890AC9.7010501@asianux.com>
Date: Tue, 7 May 2013 21:37:11 +0200
Message-ID: <CANq1E4Q8g6Uy5DMiEf3aEBmfWN=KnVCfqxErYr=ZWD94D4vmAQ@mail.gmail.com>
Subject: Re: [Suggestion] Bluetooth: hidp: redundant initialization or issue
 for function hidp_copy_session
From: David Herrmann <dh.herrmann@gmail.com>
To: Chen Gang <gang.chen@asianux.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jiri Kosina <jkosina@suse.cz>, andrei.emeltchenko@intel.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Tue, May 7, 2013 at 4:08 PM, Chen Gang <gang.chen@asianux.com> wrote:
> Hello Maintainers:
>
> In net/bluetooth/hidp/core.c, for hidp_copy_session(), the
> 'session->input' and 'session->hid' are conflict with each other.
>
> And excuse me, I do not quit know the details, but I think we have 2
> choices for fixing it:
>
>   one is ''if (session->input) { } else if (session->hid) { };''
>   the other is ''if (seesion->hid) { } else if (session->input) { };''
>
> The first choice assumes the original code has a logical issue; the
> second choice assumes the original code has redundant initialization.

The code is fine. Only one of "->input" or "->hid" can be valid at a
time. And exactly one of them is guaranteed to be valid. See
hidp_session_dev_init().

I fixed all code that I changed during the rework to say:

if (session->hid)
...
else if (session->input)
...

It makes the code more clear. But I avoided touching all the other
places that I didn't change, as the code is technically right. Anyway,
I don't care whether we want to fix all other occurrences to use "else
if". Feel free to send a patch.

Thanks
David

> Please help check.
>
> Thanks.
>
>   71 static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
>   72 {
>   73         memset(ci, 0, sizeof(*ci));
>   74         bacpy(&ci->bdaddr, &session->bdaddr);
>   75
>   76         ci->flags = session->flags;
>   77         ci->state = BT_CONNECTED;
>   78
>   79         ci->vendor  = 0x0000;
>   80         ci->product = 0x0000;
>   81         ci->version = 0x0000;
>   82
>   83         if (session->input) {
>   84                 ci->vendor  = session->input->id.vendor;
>   85                 ci->product = session->input->id.product;
>   86                 ci->version = session->input->id.version;
>   87                 if (session->input->name)
>   88                         strncpy(ci->name, session->input->name, 128);
>   89                 else
>   90                         strncpy(ci->name, "HID Boot Device", 128);
>   91         }
>   92
>   93         if (session->hid) {
>   94                 ci->vendor  = session->hid->vendor;
>   95                 ci->product = session->hid->product;
>   96                 ci->version = session->hid->version;
>   97                 strncpy(ci->name, session->hid->name, 128);
>   98         }
>   99 }
>
