Return-Path: <george.news@gmx.net>
Message-Id: <6.1.2.0.2.20040906110544.02b5be00@pop.gmx.net>
Date: Mon, 06 Sep 2004 11:07:22 +0200
To: Marcel Holtmann <marcel@holtmann.org>
From: George <george.news@gmx.net>
Subject: Re: [Bluez-users] Connect Error - Function not implemented
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1094459161.5145.12.camel@notepaq>
References: <6.1.2.0.2.20040902194629.053ab320@luna.tlmat.unican.es>
 <1094459161.5145.12.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi. I solve the problem. The reason was that I have the two peers 
configured as master and this way it's impossible to interconnect them, as 
my BT devices doesn't support that. I was trying something like an scatternet.

Thanks.

At 10:26 06/09/2004, Marcel Holtmann wrote:
 >Hi George,
 >
 >> I'm developing under kernel 2.4.21 an application that involves dealing
 >> with bluetooth devices.
 >> In order to make the application I have taken part of the code of the pand
 >> (it's opensource great!!!). My application is very similar to that. It's a
 >> daemon that firstly look for Bluetooth devices, if any found it tries to
 >> establish a bnep connection and then it runs as a server in order to be
 >> able to attend connection request. As you can see it's more or less all 
the
 >> stuff in pand. I have also automate the bridge creation, ...
 >>
 >> Well I have been checking the correct behaviour by running my application
 >> and then connecting using pand. This way everything works ok.
 >>
 >> However when running my application on two PC I get the following error
 >> from the connect statement: Function not implemented (38)
 >> Then if I try again with pand I still get the error.
 >>
 >> What is the reason for this error?
 >
 >check your role switch and master/slave settings and make sure that you
 >are not using security mode 3.
 >
 >Regards
 >
 >Marcel
