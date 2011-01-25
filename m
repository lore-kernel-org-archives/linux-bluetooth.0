Return-Path: <cyrus@holtmann.org>
Subject: Re: Read Characteristic Value vs. Read Long Characteristic Values
From: Brian Gix <bgix@codeaurora.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>
References: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 Jan 2011 11:46:25 -0800
Message-ID: <1295984785.2656.98.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Tue, 2011-01-25 at 15:07 -0400, Anderson Lizardo wrote:
> Hi Brian,
> 
> On the implementation you did for Long Characteristic value read, you
> integrated the Read Blob Request handling into the existing "Read
> Characteristic Value" implementation. From my understanding of the
> code, the read blob request is issued if the response PDU size is
> greater than or equal to LE ATT_MTU (23).
> 
> The problem I see with this approach is that if the client knows that
> the characteristic value is exactly 22 bytes (which makes total PDU
> size equal to 23 with the opcode), a spurious read blob request (and
> corresponding response) is sent. How could we avoid this overhead?
> 
> My idea was to separate the procedures, having a "Read Long
> Characteristic Value" and revert Read Characteristic Value to read
> only the first ATT_MTU - 1 bytes as before. For characteristic values
> which the client knows to be within ATT_MTU - 1 bytes (of if it only
> cares about these bytes at the time) it would use the latter. For
> cases where value length is unknown, it would use the former.
> 
> This would also allow us to better map to GATT procedures and have
> fine control on the client implementation and on our test tool
> (igatttool).
> 

>>From a practical perspective, the only attributes that would be
*exactly* 22 octets would be strings which defy attempts for a client to
predict their length without knowing what the content is ahead of time.

You are correct that if a *profile* defines a particular characteristic
attribute value to be exactly 22 octets, that this would result in
result it a harmless extra read.

For string reads this is not really a useless extra operation, because
it does supply definitive termination of the string, which per ATT
protocol cannot be provided any other way.

As far as test case coverage per the qualification test specification, I
do not believe that there is a problem.  Any non long "Reads" can be
tested by reading < 22 octet attributes, and long read tests by reading
>= 22 octet attributes. 



-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

