Return-Path: <cyrus@holtmann.org>
From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Rafael Seste <rseste@gmail.com>
Subject: Re: bluez 4.x, SCO socket - connection reset by peer
Date: Thu, 21 May 2009 13:46:27 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <5d223510905201349w416f50cal520dde1281f90bc7@mail.gmail.com>
In-Reply-To: <5d223510905201349w416f50cal520dde1281f90bc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905211346.28693.Hugo.Mildenberger@namir.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, 20. Mai 2009 schrieb Rafael Seste:
> Hi,
> 
> I trying to use asterisk (with chan_mobile) to connect with my mobile phone.
> When there is a incoming/outgoing call, this module creates a
> sco_socket to send/receive audio packets.
> 
> socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)
> 
> when this socket is ready...it can write data once, after that when it
> tries to read an error is returned:
> 
> sco_read() error 104
> 
> 104 means - connection reset by peer
> 
> after this i got error 107 - not connect.
> 
> Some one knows why is the reason of this error 104???
> 
> kernel 2.6.22.18
> bluez 4.32
> 
> tks


Are you also using a Nokia cell phone? This error
is likely a consequence of the patch introduced by
  
https://issues.asterisk.org/view.php?id=15037 

Maybe you would like to report your setup also here:
 
https://issues.asterisk.org/view.php?id=15075


Best Regards

