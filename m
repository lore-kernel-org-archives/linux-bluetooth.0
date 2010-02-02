Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <272603.59641.qm@web52603.mail.re2.yahoo.com>
References: <272603.59641.qm@web52603.mail.re2.yahoo.com>
Date: Tue, 2 Feb 2010 15:41:28 -0600
Message-ID: <8a7a8d7b1002021341j2d9835f6m13e697aad2a41f59@mail.gmail.com>
Subject: Re: double Connect req: psm 1 scid 0x0040 ?
From: Liejun Tao <liejuntao001@gmail.com>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 2, 2010 at 2:33 PM, Ed Tsang <netdesign_98@yahoo.com> wrote:
>
> Hi all,
>  I was pulling my hair on opp a file to a Blackberry. Blackerry is set to "receive using bluetooth".
> 1. If the Blackberry was not paired before. It ran through ok: enter the pin, accept connection, accept the file.
> 2. If the Blackberry was paired and in it's device properties, I change the encryption off for my box. It ran through ok, accept connection, accept the file...
> 3. If the Blackberry was paired and I leave the device properties unchange (default is encryption on). It will fail, not seeing any prompt to accept the connection.
>
> In hcidump I seem to see a problem in #3. After the Encrypt Change there seem to be 2 >con. req. psm 1 scid 0x0040
>
> Any suggestion on how to trace it down/work around this?
> .............
>
> > HCI Event: Read Remote
> Supported Features (0x0b) plen 11
> < ACL data: handle 42 flags
> 0x02 dlen 10
>    L2CAP(s): Info req: type 2
> > HCI Event: Number of
> Completed Packets (0x13) plen 5
> > HCI Event: Encrypt Change
> (0x08) plen 4
> < ACL data: handle 42 flags
> 0x02 dlen 12
>    L2CAP(s): Connect req: psm 1 scid 0x0040
> > ACL data: handle 42 flags
> 0x02 dlen 12
>    L2CAP(s): Info rsp: type 2 result 1
>      Not supported
> < ACL data: handle 42 flags
> 0x02 dlen 12
>    L2CAP(s): Connect req: psm 1 scid 0x0040
> > HCI Event: Number of
> Completed Packets (0x13) plen 5
> > HCI Event: Number of
> Completed Packets (0x13) plen 5
> > ACL data: handle 42 flags
> 0x02 dlen 16
>    L2CAP(s): Connect rsp: dcid 0x0040 scid
> 0x0040 result 0 status 0
>      Connection successful
> < ACL data: handle 42 flags
> 0x02 dlen 12
>    L2CAP(s): Config req: dcid 0x0040 flags
> 0x00 clen 0
> > ACL data: handle 42 flags
> 0x02 dlen 16
>    L2CAP(s): Connect rsp: dcid 0x0041 scid
> 0x0040 result 4 status 0
>      Connection refused - no resources
> available
> .................
> Regards, Ed
>
>
>
>      __________________________________________________________________
> Get a sneak peak at messages with a handy reading pane with All new Yahoo! Mail: http://ca.promos.yahoo.com/newmail/overview2/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm trying to resolve this issue. Let me post the patch for review.
