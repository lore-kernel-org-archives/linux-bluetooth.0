Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000001cbbe58$982b5fd0$c8821f70$@org>
References: <1295654876.1774.24.camel@ubuntuLab1>
	<AANLkTi=gLKMvWuUeyjqGBQuWd5ztjjr10d44H4A1fFfZ@mail.gmail.com>
	<000001cbbe58$982b5fd0$c8821f70$@org>
Date: Fri, 28 Jan 2011 14:03:06 +0800
Message-ID: <AANLkTinm=56sTExsyMgQSFkKCe5Ere8X4RY6aYxQugfS@mail.gmail.com>
Subject: Re: Attribute Server and Client TODOs
From: Erin Yueh <erinyueh@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Fri, Jan 28, 2011 at 03:30, Inga Stotland <ingas@codeaurora.org> wrote:
[...]
> Thank you for your response about enabling GATT over D-Bus.
> I was following the instructions from your notes.
> However, when trying to test D-Bus operations for GATT, I cannot seem to get
> org.bluez.Characteristic interface to register...
> Have you been able to get GATT D-Bus interface to work just with BR/EDR (no LE)?

yup! I am able to use GATT related D-Bus interface to work with
BR/EDR. In the beginning, back to Bluez release 4.80, we can trigger
the discovering service when registering the client. Then it can store
few files in /var/lib/bluetooth/BT_ADDR. When we start bluetooth
daemon, it would register GATT D-Bus interface based on those files.
If you'd like to see those D-Bus interface, you could rollback to
release 4.80. You can use gatttoool to discover the primary service,
and copy 'primary', 'attributes' and 'characteristic' files. Then you
could use the latest Bluez, but move those files to the same folder.
You should be able to see the GATT D-Bus interface.

>
> Thanks,
>
> Inga Stotland
>
> ingas@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>

Regards,
Erin Yueh
