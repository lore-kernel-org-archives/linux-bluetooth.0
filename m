Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030515171955.0d4a34f8@unixmail.qualcomm.com>
Date: Thu, 15 May 2003 17:38:39 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] RFCOMM server problem
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052950924.4608.68.camel@pegasus.local>
References: <5.1.0.14.2.20030514093502.0d45fe08@unixmail.qualcomm.com>
	<5.1.0.14.2.20030514093502.0d45fe08@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:21 PM 5/14/2003, Marcel Holtmann wrote:
>        Sony C1VE       2.4.20-mh7 (plus bt-2.4)
>        Pentium 4       2.4.20-mh7 (plus bt-2.4 except the LM_RELIABLE)
>
>The problem only happens if I want to connect from my C1VE to the P4.
>The other direction is working fine. I ran hcidump on both sides and
>also on the P4 side I see the SABM package, but the rfcomm.o module is
>not reacting. For me it looks like an initial processing of incoming
>packets is missing. Did you have any other idea?
I cannot reproduce that. I just tried to connect from my Dual PPro, which 
is still running 2.4.21-pre4 with no updates to BT stuff, to my laptop
with very latest bt-2.4. 
I get normal trace
1053045305.509342 > RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
1053045305.509438 < RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
1053045305.540498 > RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
  dlci 20 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size 1019 max_retrans 0 credits 7
1053045305.540619 < RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
  dlci 20 frame_type 0 credit_flow 14 pri 0 ack_timer 0 frame_size 1019 max_retrans 0 credits 7
1053045305.549164 > RFCOMM(s): SABM: cr 1 dlci 20 pf 1 ilen 0 fcs 0xfd 
1053045305.549206 < RFCOMM(s): UA: cr 1 dlci 20 pf 1 ilen 0 fcs 0x36 
1053045305.549248 < RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
  dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1053045305.579298 > RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
  dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1053045305.579387 < RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
  dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1053045305.579660 > RFCOMM(d): UIH: cr 1 dlci 20 pf 1 ilen 0 fcs 0x2d 
1053045305.589091 > RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
  dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1053045305.589117 < RFCOMM(d): UIH: cr 0 dlci 20 pf 1 ilen 0 fcs 0xf7 

(first UIH sent before last MSC response came from 2.4.21-pre4 
which doesn't have MSC fixes).

So. I'm absolutely sure that new code is 100% compatible with the old one. I see
no delays in SABM processing.
And I have no idea what's going on with your P4 :).

Max
