Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH BlueZ 1/1] GATT shim to src/shared bt_att
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25Tz98y=s4nPy6pabstTFAW+dO6XX=hqhjN=gZt_cP0YcQ@mail.gmail.com>
Date: Mon, 20 Oct 2014 22:30:06 +0200
Cc: Michael Janssen <jamuraa@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <CE5385E7-AA36-4134-8D6E-76DDC4BC25FD@holtmann.org>
References: <1413824244-35297-1-git-send-email-jamuraa@chromium.org> <1413824244-35297-2-git-send-email-jamuraa@chromium.org> <526D5B5F-0DB1-4FED-B193-59B2604BE719@holtmann.org> <CAHrH25Tz98y=s4nPy6pabstTFAW+dO6XX=hqhjN=gZt_cP0YcQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> This patch implements a version of GAttrib which is backed by
>>> bt_att, which enables the simultaneous use of GAttrib and bt_att.
>>> 
>>> This should enable smooth transition of profiles from the GAttrib
>>> API to the src/shared bt_att API.
>>> ---
>>> Makefile.am             |   8 +-
>>> Makefile.tools          |  11 +-
>>> attrib/gattrib-shared.c | 306 ++++++++++++++++++++++++++++++++++++++++++++++++
>>> configure.ac            |   4 +
>>> 4 files changed, 327 insertions(+), 2 deletions(-)
>>> create mode 100644 attrib/gattrib-shared.c
>> 
>> to be honest, I would convert this in one go. If we can have a shim that just provides the GAttrib API, then lets use that and put it into src/ and remove attrib/ directory.
>> 
> 
> Not sure what exactly you mean here by converting this in one go.
> There is still a lot of code in attrib/ that is needed in conjunction
> with GAttrib, such as all the ATT protocol encode/decode functions and
> GATT procedure wrappers, so we are going to have to compile that stuff
> in anyway and moving all of that into src/ doesn't make much sense to
> me. So, for the shim, it made sense to put it in attrib/ initially.

keeping it in attrib/ directory is fine with me as well. What I do not understand is why we need the compile time switch. Just for using bt_att underneath.

Regards

Marcel

