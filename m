Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030210123957.0417f4c0@mail1.qualcomm.com>
Date: Mon, 10 Feb 2003 12:49:47 -0800
To: Alexandros Karypidis <karypid@inf.uth.gr>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <200302081740.48000.karypid@inf.uth.gr>
References: <1044653775.32672.14.camel@pegasus.local>
	<200302071951.35073.karypid@inf.uth.gr>
	<200302072329.21333.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>


>As I can see in lines 462-470 of core/l2cap.c, either the bind() fails if the 
>PSM is in use, or it succeeds if it is free. I think this is where the code 
>for the case l2_bdaddr->psm==0 should be added, changing the value to some 
>free PSM.
>
>In this case, I am thinking of adding a 8192 byte array in l2cap.c, which 
>records (per bit) the PSMs which are in use. This idea is similar to the way 
>the kernel tracks the signals which should be masked per process. One would 
>then:
>
> // 0xFFFF PSMs available = 8192 bytes
>#define MAX_PSM_NDX 8192
>// Record PSM use here in the following array:
>unsigned char psm_use[MAX_PSM_NDX];
>// Code which should be added to l2cap.c in l2cap_sock_bind()
>for (i=513; i<MAX_PSM_NDX; i++) { // start a 513 to skip reserved PSMs
>        if (psm_use[i] < 255) { // a bit which is not set means there is a free PSM
>                // bit ops to locate the first 0 bit
>                // change the ls->psm value to that bit's index
>                // set the bit to 1 to record it as in use
>        }
>}
>
>Then, I suppose that code must be added to set the bit back to 0 when close() 
>is called, plus in accept() when new sockets are created for clients. I can't 
>think of any other points of interaction.
Currently psm zero means that socket doesn't have PSM assigned to it.
bind(psm==0) means that application doesn't need PSM it's simply wants to 
bind it's socket to some BD address. Which is exactly what L2CAP clients need.
So you proposing a change that will brake current bind() interface. Well I guess
it won't really break it but it will allocated PSM for all client apps which 
doesn't make any sense. 

Why do you think we need dynamic PSM allocation ? l2cap already allocates CIDs
dynamically. I don't see why people would want the same thing for PSMs.

Max
