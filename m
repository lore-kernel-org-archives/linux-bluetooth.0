Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf05040500404049cda4@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluepin ERROR with RFCOMM
In-Reply-To: <1112608067.8263.25.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f16b04cf05033022021405d585@mail.gmail.com>
	 <1112554304.8263.0.camel@pegasus>
	 <f16b04cf05040323102b9160a1@mail.gmail.com>
	 <1112608067.8263.25.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 5 Apr 2005 13:10:37 +0530

Hi Marcel,
Thanks for your support on Obex ftp. But i am disturbing you agian
with the problem i am facing.

I have run the HCID, SDPD, OBEXFTPD and OPD daemon in the 
OBEX server machine.
Then i have run the HCID, SDPD , OPD daemon in the client machine.
I can able to send the file from client to server.

But when i try to get the file from the server. i am getting the error of

Browsing 00:0B:0D:33:DA:F9 ...
No custom transport
Connecting...bt: 1
done
Receiving /tmp/hci.h... failed: /tmp/hci.h
Disconnecting...done

When i watching the HCIDump information, i could able to find 
out upto the L2CAP, SDP query ,L2CAP link for RFCOMM connection works fine, 
while setting up the RFCOMM link for OBEX server gives the DISC 
command.

I had provided the client side HCIDUMP information for your kind reference

< ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 3 fcs 0x9a
      81 00 03
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 3 fcs 0x40
      A0 00 03
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
  28 00 13

Thanks and regards
Hariharan.v.

On Apr 4, 2005 3:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hariharan,
> 
> >                  Thanks for your support. i have brought uo n\my
> > bluetooth interface with
> > the RFCOMM.
> >                     Now i going into the Obex file transfer. is there
> > any bluez utility to test
> > the Obex and the Installation of Obex document.
> 
> check programs like obexftp, obextool or the btobex and btftp from the
> BlueZ OBEX CVS repository.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
