Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4736EBDA617@shsmsx501.ccr.corp.intel.com>
References: <CE761E84DADF2947A4AF22FB8D97A4736EBDA617@shsmsx501.ccr.corp.intel.com>
Date: Mon, 21 Nov 2011 11:30:26 +0200
Message-ID: <CABBYNZKB+3ZMxS9ChOK=BwgGqQgN1qdZWPtg1rMp4x_VfPtjtQ@mail.gmail.com>
Subject: Re: Problems for obex-0.42 (obex-client)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 21, 2011 at 10:43 AM, Zheng, Wu <wu.zheng@intel.com> wrote:
> Hi:
>
> We use the test script of obexd-0.42/test/ftp-client for testing ftp.
> Obex-0.41 is ok for the test.
> However, for obex-0.42, We find the following issue:
>
> obex-client[4144]: obex-client daemon 0.42
> obex-client[4144]: client/main.c:main() Entering main loop
> obex-client[4144]: client/session.c:session_ref() 0x9d80af8: ref=2
> obex-client[4144]: client/session.c:manager_reply() adapter path /org/bluez/345/hci0
> obex-client[4144]: manager replied with an error: org.bluez.Error.AgentNotAvailable, Agent Not Available
> obex-client[4144]: client/session.c:session_unref() 0x9d80af8: ref=1
> obex-client[4144]: client/session.c:owner_disconnected()
> obex-client[4144]: client/session.c:session_shutdown() 0x9d80af8
>
> After checking the code of obexd-0.42 and obexd-0.41, we find that obexd-0.42 need to send dbus a message call to bluez for invoking RequestSession()
>
> In the function of RequestSession() in the file of adapter.c,
>        if (!adapter->agent)
>                return btd_error_agent_not_available(msg);
>
> The root cause is that obex-client did not register a agent for bluez, therefore, the error is " manager replied with an error: org.bluez.Error.AgentNotAvailable, Agent Not Available ".
>
> For the cases, I think that obex-client need to register a agent for bluez? Or the other idea?
> Someone has comments for it?

If you don't have an agent registered then your system cannot
authenticate/authorize connections and obex-client should not register
itself as an agent since it is not suppose to act as one, so something
else is happening that your system is not registering any agent
(normally some gui component), if you want this just for testing you
can use simple-agent script.

-- 
Luiz Augusto von Dentz
