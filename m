Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Adding Additional Protocol Descriptor List
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051213092433.81132.qmail@web32401.mail.mud.yahoo.com>
References: <20051213092433.81132.qmail@web32401.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1134471609.29210.15.camel@blade>
Mime-Version: 1.0
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
Date: Tue, 13 Dec 2005 12:00:09 +0100

Hi Arch,

> Thank you with that information on adding the 1284ID attribute.

you are welcome. I assume it is working perfect now.
 
> Now, I am trying to add the Additional Protocol Descriptor List to my
> sdp record. The Additional Protocol Descriptor List is almost similar
> to the Protocol Descriptor List. The only difference is that while the
> Protocol Descriptor List is a sequence of a sequence of data (2
> levels),  the Additional Protocol Descriptor List is a sequence of a
> sequence of a sequence of data (3 levels) .I tried doing this using
> the function sdp_set_access_protos() and just substituting the
> Attribute ID in the function from SDP_ATTR_PROTO_DESC_LIST to
> SDP_ATTR_ADD_PROTO_DESC_LIST. However, as you may already know, this
> will not solve it since the Protocol Descriptor List is only a
> sequence of a sequence.
>  
> In this regard, I would like to ask how I will be able to add a
> sequence of a sequence of a sequence of data to my sdp record. Or in
> other words, how will I add the Additional Protocol Descriptor List to
> my sdp record.

And again Collin already ran into the same problem, because you also
need them for HID. So I think we need a sdp_set_add_access_protos()
function for this job. Feel free to send me a patch.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
