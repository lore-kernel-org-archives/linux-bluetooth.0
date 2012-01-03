Return-Path: <cyrus@holtmann.org>
From: Hendrik Sattler <post@hendrik-sattler.de>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 3/4] gobex: automatically use SRM when transport type is SOCK_SEQPACKET
Date: Tue, 3 Jan 2012 16:58:16 +0100
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com> <1325598744-18855-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1325598744-18855-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201201031658.17771.post@hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, 3. Januar 2012, 14:52:23 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This simplifies the applications so SRM setup phase became transparent
> while using SOCK_SEQPACKET which is useful for GOEP 2.0 since in that
> case we can only use SRM if the transport is L2CAP.
> 
> This also follows GOEP 2.0 Page 14 - 4.6 Using Single Response Mode:
> 
>   "The Server cannot issue an enable request, but can only issue a
>   response to an enable request from the Client. SRM will remain in
>   effect for the duration of the operation that enabled it (PUT or GET)
>   ...
>   SRM headers shall not be sent in CONNECT request or response packets."
> 
> and Page 22 - 5.4 Establishment of OBEX Connection:
> 
>   "SRM headers shall not be sent in the Connect request or response
>   packets (note, this is to preserve backwards compatibility). SRM shall
>   be enabled through Put and Get operations only."
> 
> So only in case of PUT or GET requests SRM is automatically configured,
> applications can still enable it manually for other operations by adding
> the headers like before but it is not recommended.
> 
> Note that it would be a good practice to indicate SRM support by using
> value 0x02, but since that should happens during CONNECT command it is
> not done automatically for requests when acting as a client, server
> responding to indicate requests will automatically add SRM headers though.

I think you misread the specs here.

SRM is not enabled for "requests" but for sessions and SRM is valid until 
disabled again. This includes _all_ requests and responses, not only GET and 
PUT but the authors of the OBEX spec have a strange way to write things.
The SRMP headers only affect PUT and PUT, though.

Additionally, the spec says:
"Client devices supporting SRM must issue a Single Response Mode (SRM) header 
[...] during all CONNECT requests [...]".

HS
