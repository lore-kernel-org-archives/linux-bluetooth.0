Return-Path: <oscarp@acay.com.au>
Message-ID: <4167DB4C.6000504@acay.com.au>
Date: Sat, 09 Oct 2004 22:36:28 +1000
From: O Plameras <oscarp@acay.com.au>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: rfcommX and ppp
References: <41629C2B.4040201@3wt.com.br>	 <1096991861.20349.73.camel@pegasus>  <4162D886.8010406@3wt.com.br> <1097055892.4937.3.camel@pegasus>
In-Reply-To: <1097055892.4937.3.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
> 
> try to use 10.0.0.1: or other way around. Or you can define multiple
> options.rfcommX files in /etc/ppp/ and use a bridge. There are some ways
> to get this working.
> 


I learned from PPP lists that ppp0 interface bridging is not supported
nor is their a patch under 2.6.x or pppd.

When I do this,
brctl addif br0 ppp0

it returns,
br_add_interface: Invalid argument

Nobody is doing work on these at the moment is my understanding.
