Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030211105333.042bad40@mail1.qualcomm.com>
Date: Tue, 11 Feb 2003 10:58:32 -0800
To: Alexandros Karypidis <karypid@inf.uth.gr>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <200302111926.14743.karypid@inf.uth.gr>
References: <1044964883.19214.46.camel@linux>
	<200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<1044964883.19214.46.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 07:26 PM 2/11/2003 +0200, Alexandros Karypidis wrote:
>An alternative which I may suggest is to define a socket option which may be 
>set using setsockopt(), previously to calling bind(). Then, one might do this 
>via:
>
>        enable = 1;
>        s = socket (...);
>        setsockopt (s, SOL_SOCKET, BT_DYNAMIC_PSM, &enable, sizeof(enable));
>        bind (s, ... );

Yeah, I think this would be an acceptable solution which doesn't brake current API.
Servers would have to enable DYNAMIC_PSM socket option and bind to PSM 0.
Why don't you go ahead implement that and send me a patch.

Max
