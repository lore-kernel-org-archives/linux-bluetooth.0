Return-Path: <karypid@inf.uth.gr>
From: Alexandros Karypidis <karypid@inf.uth.gr>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
Date: Tue, 11 Feb 2003 19:26:14 +0200
Cc: bluez-devel@lists.sourceforge.net
References: <200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<1044964883.19214.46.camel@linux>
In-Reply-To: <1044964883.19214.46.camel@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-7"
Message-Id: <200302111926.14743.karypid@inf.uth.gr>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tuesday 11 February 2003 14:01, Marcel Holtmann wrote:

> > Now if people really want dynamic PSMs. We could introduce something like
> > bind(psm == 0xffff).
>
> I think this is not a good idea, because 0xffff is a valid PSM according
> to the spec.

That is true. A simple problem that may arrise is that, suppose I write a 
program which binds to PSM 0xffff. This is my PSM of choice and I am not 
using BlueZ. However, if I try to port my program to a Linux architecture 
which uses BlueZ, my program may compile but will not run correctly. BlueZ 
would redirect it to another PSM ands clients would make connection attempts 
to 0xffff which would fail.

> But what about bind it with PSM 0 and the listen call assign a dynamic
> PSM if it is bind with PSM 0 ?

That is what I was suggesting BUT: in IP, there is no way that a conneted 
socket will ever return port==0. This is why it may be used as a special 
value for bind().

In BT however, there is no "illegal" PSM value. I do not know this, but Max 
mentioned that a client by default uses PSM zero if he does not specify one. 
Indeed, in the test I mentioned in previous e-mails, using getsockname() will 
return PSM 0 when you connect() without previously calling bind(). Plus, one 
may explicitly bind() to PSM==0 and then connect() on the basis of current 
behavior and instead get another PSM because of this change. Quoting Max:

"Currently psm zero means that socket doesn't have PSM assigned to it.
bind(psm==0) means that application doesn't need PSM it's simply wants to 
bind it's socket to some BD address. Which is exactly what L2CAP clients need.
So you proposing a change that will brake current bind() interface. Well I 
guess it won't really break it but it will allocated PSM for all client apps 
which doesn't make any sense."

An alternative which I may suggest is to define a socket option which may be 
set using setsockopt(), previously to calling bind(). Then, one might do this 
via:

	enable = 1;
	s = socket (...);
	setsockopt (s, SOL_SOCKET, BT_DYNAMIC_PSM, &enable, sizeof(enable));
	bind (s, ... );

-- 
To err is human, but to forgive is beyond the scope of the Operating System...

Alexandros Karypidis
University of Thessaly
Computer & Communications Engineering dept.
