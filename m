Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110830100743.GB20356@dell>
References: <1313791842-32558-1-git-send-email-bdilly@profusion.mobi>
	<1313791842-32558-3-git-send-email-bdilly@profusion.mobi>
	<20110830100743.GB20356@dell>
Date: Tue, 30 Aug 2011 10:07:11 -0300
Message-ID: <CAND=sy97PS4Mtr_7bSqEmHXpdMPGxDUHjHBG36dHk2CcOu6riA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Add test for serial proxy and serial proxy manager
From: Bruno Dilly <bdilly@profusion.mobi>
To: Bruno Dilly <bdilly@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 30, 2011 at 7:07 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Bruno,

Hey Johan,

>
> On Fri, Aug 19, 2011, Bruno Dilly wrote:
>> ---
>>  test/test-serial-proxy |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 64 insertions(+), 0 deletions(-)
>>  create mode 100755 test/test-serial-proxy
>
> This one is missing the corresponding update to EXTRA_DIST in
> Makefile.tools. Without it the new script will not go to the "make dist"
> tarball.

Oops, I've sent a new version.

Thank you very much,

>
> Johan
>



-- 
Bruno Dilly
Senior Developer
ProFUSION embedded systems
http://profusion.mobi
