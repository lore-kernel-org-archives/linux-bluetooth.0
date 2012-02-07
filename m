Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJameNM2VOMRK=qvZLGfUNM+Zhr6YgYS0vs+UwACSz-9Q@mail.gmail.com>
References: <1328634264-9931-1-git-send-email-frederic.dalleau@linux.intel.com>
	<CABBYNZJameNM2VOMRK=qvZLGfUNM+Zhr6YgYS0vs+UwACSz-9Q@mail.gmail.com>
Date: Tue, 7 Feb 2012 20:30:42 +0100
Message-ID: <CA+QXtDs=fSFcLVrqBfmaKXNod1rAqSxuUL2i8Xj_LfcwL2a61Q@mail.gmail.com>
Subject: Re: [PATCH] gateway: Fix crash if SCO connection fails
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

2012/2/7 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Hi Frédéric,
> It doesn't seems this change anything since the id is always returned
> anyway, have you tried to reproduce it while running with valgrind?

There is one case where the function returns 0.
It doesn't appear in the patch, but you can check in the code.
However I haven't tested with valgrind.

Regards,
Frédéric
