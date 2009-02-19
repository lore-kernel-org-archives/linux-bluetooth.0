Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/4] HFP Gateway profile -- take 2
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	event <event.riga@gmail.com>
In-Reply-To: <ac8af0be0902190519v150905c9iea04a86835750c5c@mail.gmail.com>
References: <ac8af0be0902190519v150905c9iea04a86835750c5c@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 19 Feb 2009 19:33:48 +0100
Message-Id: <1235068428.4640.10.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> Compared with last version the change is:
> 1 fix the bug that HFP AG can't initiate the service-level connection
> with HFP HF unit.
> 2 rebase the patch set against the BlueZ master
> 
> The patch set include the following 4 patches:
> 1 add the D-Bus interface definition for HFP Audio gateway
> 2 add the basic framework support for HFP Audio gateway
> 3 the main part for HFP Audio gateway
> 4  IPC integration part for HFP Audio gateway

before we go any further with this, please make sure the coding style is
fixed.

static GDBusSignalTable gateway_signals[] = {
       {NULL, NULL}
};

It has to be "{ NULL, NULL }" and there are multiple of these mistakes.

And second, did you actually compiled the code?

       GIOChannel *rfcomm = gw->rfcomm;

       if (!io_channel_write_all(rfcomm, data, count))
               return FALSE;

       gsize read = 0;
       gboolean got_ok = FALSE;

This will not compile since you have variable declarations after the
code and the latest changes with -Werror are clearly forbidding this and
also checking for it.

Regards

Marcel


