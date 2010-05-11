Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 May 2010 18:23:26 +0100 (BST)
To: Serhiy Kachaniuk <serzholino@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bugreport]
In-Reply-To: <AANLkTilEsIYKxwdD4ZLbYaIExMlHfEmpuOnj8BKeI4XP@mail.gmail.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>  <4BE270EE.5080306@greffrath.com>  <u2z793f89501005060256g3eb32a09ncff16e8e454bdcc@mail.gmail.com>  <1273589222.840882.854.nullmailer@galant.ukfsn.org>
 <AANLkTilEsIYKxwdD4ZLbYaIExMlHfEmpuOnj8BKeI4XP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1273598606.491570.554.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 11 May 2010, Serhiy Kachaniuk wrote:

> Yeah, i see that this device is a little buggy, but it worked in
> previous version of bluez, so maybe it is possible to make it work
> again for current version?

I think the problem may be that the kernel itself now relies on setting
the default link policy before accepting connections, so that the link
policy does not need to be set after the connection is complete and there
will be no window of uncertainty.

I am only an observer here, and don't know if this has been done with the
conscious knowledge that older devices will no longer work or if it was a
mistake..  but I can suggest that Bluetooth dongles are cheap, and you
will likely find better connectivity with a 2.x + EDR device anyway..

regards,
iain


