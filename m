Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] more sdp patches
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1133509258.15695.8.camel@panic>
References: <1133509258.15695.8.camel@panic>
Content-Type: text/plain
Message-Id: <1133552877.24022.5.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 02 Dec 2005 20:47:57 +0100

Hi Collin,

> here is another patch for bluez-libs for sdp. I added:
> 
> int sdp_set_access_protos_attr(sdp_record_t *rec, const sdp_list_t
> *proto, const uint16_t attr);
> 
> this is to add stuff like SDP_ATTR_ADD_PROTO_DESC_LIST, actually I
> modified sdp_set_access_protos to take another parameter and made
> sdp_set_access_protos do a call to sdp_set_access_protos_attr to keep
> backward compatibility

this won't work, because the additional protocol descriptor list is a
sequence of sequence of sequence. Compare this from my HCRP capable
printer:

Attribute 0x0004 - ProtocolDescriptorList
        Sequence
                Sequence
                        UUID16 0x0100 - L2CAP
                        UINT16 0x1003
                Sequence
                       UUID16 0x0012 - HardcopyControlChannel

Attribute 0x000d - AdditionalProtocolDescriptorLists
        Sequence
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                                UINT16 0x1001
                        Sequence
                                UUID16 0x0014 - HardcopyDataChannel


Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
