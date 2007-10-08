Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100710081056m6391d8aao6fbc2d2b1aa34948@mail.gmail.com>
References: <de4879e80710011431q3fa8c870m95a08dc46ea9a679@mail.gmail.com>
	<de4879e80710051236j243ff5c6mc6bd18e5c43640a6@mail.gmail.com>
	<2d5a2c100710081056m6391d8aao6fbc2d2b1aa34948@mail.gmail.com>
Date: Tue, 09 Oct 2007 00:56:34 +0200
Message-Id: <1191884194.12212.13.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Patch: inheritance problem in gsta2dpsink
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Luiz,

> I guess we really need a tiny library for ipc, we dont want to
> duplicate code from
> pcm_bluetooth.c again in a2dpsink, it might happen that someone need this
> in another plugin or so.

no no and no. I don't care what other plugins (outside bluez-utils) need
and want at the moment. It is perfectly fine to link an object file more
than once. That must be enough and a library in the end is nothing
different.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
