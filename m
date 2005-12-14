Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051214073020.77669.qmail@web32409.mail.mud.yahoo.com>
From: Arch Sayo <a12chi@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1249044936-1134545420=:77324"
Subject: [Bluez-users] Re: adding Additional Protocol Descriptor List
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
Date: Tue, 13 Dec 2005 23:30:20 -0800 (PST)

--0-1249044936-1134545420=:77324
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,
   
  I have tried writing code to add the Additional Protocol Descriptor List. But it seems that the data still cannot be added as a 3-level sequence (sequence of a sequence of a sequence). The data I added for the Additional Protocol Descriptor List still look similar to the Protocol Descriptor List (2-level sequence of data).
   
  Here is the code corresponding to adding the SDP attribute:
   
  int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
{
      const sdp_list_t *p;
  const sdp_list_t *pp;
  sdp_data_t *protos = 0;

  
  for (p = ap->data; p; p = p->next) {
    sdp_data_t *seq = access_proto_to_dataseq2(rec, (sdp_list_t *)p->data);
    protos = sdp_seq_append(protos, seq);  // protos = seq;
  }

  sdp_attr_add(rec, SDP_ATTR_ADD_PROTO_DESC_LIST, protos);
  return 0;
}


int add_additional_proto(void)
{

   /* Add Additional Protocol Descriptor List */
   sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
   proto2[0] = sdp_list_append(0, &l2cap_uuid);
   apseq3 = sdp_list_append(0, proto2[0]);
   apseq2 = sdp_list_append(0, apseq3);

   sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
   proto2[1] = sdp_list_append(0, &rfcomm_uuid);

   channel2 = sdp_data_alloc(SDP_UINT8, &chan2);
   proto2[1] = sdp_list_append(proto2[1], channel2);
   apseq3 = sdp_list_append(apseq3, proto2[1]);
 
   sdp_uuid16_create(&obex_uuid, OBEX_UUID);
   proto2[2] = sdp_list_append(0, &obex_uuid);
   apseq3 = sdp_list_append(apseq3, proto2[2]);
 
   addproto = sdp_list_append(0, apseq3);

   sdp_set_add_access_protos(&record, addproto);
  
   return 0;
}

   
  As you can see, I changed the attribute ID to correspond to SDP_ATTR_ADD_PROTO_DESC_LIST (0x000d) in the sdp_set_add_access_protos(). However, the data was not added correctly. I would like to ask in what other parts of the code should I make corresponding changes to add the sdp data correctly.
   
  Thank you for your time and efforts.
   
  Arch Sayo
   
   
  Hi Arch,

> Thank you with that information on adding the 1284ID 
attribute.

you are welcome. I assume it is working perfect now.
 
> Now, I am trying to add the Additional Protocol 
Descriptor List to my
> sdp record. The Additional Protocol Descriptor List 
is almost similar
> to the Protocol Descriptor List. The only difference 
is that while the
> Protocol Descriptor List is a sequence of a sequence 
of data (2
> levels),  the Additional Protocol Descriptor List is 
a sequence of a
> sequence of a sequence of data (3 levels) .I tried 
doing this using
> the function sdp_set_access_protos() and just 
substituting the
> Attribute ID in the function from 
SDP_ATTR_PROTO_DESC_LIST to
> SDP_ATTR_ADD_PROTO_DESC_LIST. However, as you may 
already know, this
> will not solve it since the Protocol Descriptor List 
is only a
> sequence of a sequence.
>  
> In this regard, I would like to ask how I will be 
able to add a
> sequence of a sequence of a sequence of data to my 
sdp record. Or in
> other words, how will I add the Additional Protocol 
Descriptor List to
> my sdp record.

And again Collin already ran into the same problem, 
because you also
need them for HID. So I think we need a 
sdp_set_add_access_protos()
function for this job. Feel free to send me a patch.

Regards

Marcel


			
---------------------------------
Yahoo! Shopping
 Find Great Deals on Holiday Gifts at Yahoo! Shopping 
--0-1249044936-1134545420=:77324
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Marcel,</div>  <div>&nbsp;</div>  <div>I have tried writing code to add the Additional Protocol Descriptor List. But it seems that the data still cannot be added as a 3-level sequence (sequence of a sequence of a sequence). The data I added for the Additional Protocol Descriptor List still look similar to the Protocol Descriptor List (2-level sequence of data).</div>  <div>&nbsp;</div>  <div>Here is the code corresponding to adding the SDP attribute:</div>  <div>&nbsp;</div>  <div class=MsoPlainText style="MARGIN: 0in 0in 0pt"><FONT face="Courier New">int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)<BR>{<BR><SPAN style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>const sdp_list_t *p;<BR><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>const sdp_list_t *pp;<BR><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>sdp_data_t *protos = 0;<BR><BR><SPAN style="mso-spacerun: yes">&nbsp; </SPAN><BR><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>for (p =
 ap-&gt;data; p; p = p-&gt;next) {<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>sdp_data_t *seq = access_proto_to_dataseq2(rec, (sdp_list_t *)p-&gt;data);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>protos = sdp_seq_append(protos, seq);<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>// protos = seq;<BR><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>}<BR><BR><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>sdp_attr_add(rec, SDP_ATTR_ADD_PROTO_DESC_LIST, protos);<BR><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>return 0;<BR>}<BR><BR><BR>int add_additional_proto(void)<BR>{<BR><BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>/* Add Additional Protocol Descriptor List */<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>sdp_uuid16_create(&amp;l2cap_uuid, L2CAP_UUID);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>proto2[0] = sdp_list_append(0, &amp;l2cap_uuid);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>apseq3 = sdp_list_a
 ppend(0,
 proto2[0]);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>apseq2 = sdp_list_append(0, apseq3);<BR><BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>sdp_uuid16_create(&amp;rfcomm_uuid, RFCOMM_UUID);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>proto2[1] = sdp_list_append(0, &amp;rfcomm_uuid);<BR><BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>channel2 = sdp_data_alloc(SDP_UINT8, &amp;chan2);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>proto2[1] = sdp_list_append(proto2[1], channel2);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>apseq3 = sdp_list_append(apseq3, proto2[1]);<BR><SPAN style="mso-spacerun: yes">&nbsp;</SPAN><BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>sdp_uuid16_create(&amp;obex_uuid, OBEX_UUID);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>proto2[2] = sdp_list_append(0, &amp;obex_uuid);<BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>apseq3 = sdp_list_append(apseq3, proto2[2]);<BR><
 SPAN
 style="mso-spacerun: yes">&nbsp;</SPAN><BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>addproto = sdp_list_append(0, apseq3);<BR><BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>sdp_set_add_access_protos(&amp;record, addproto);<BR><SPAN style="mso-spacerun: yes">&nbsp; </SPAN><BR><SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>return 0;<BR>}</FONT><BR></div>  <div>&nbsp;</div>  <div>As you can see, I changed the attribute ID to correspond to <FONT face="Courier New">SDP_ATTR_ADD_PROTO_DESC_LIST (0x000d) </FONT>in the <FONT face="Courier New">sdp_set_add_access_protos().</FONT>&nbsp;However, the data was not added correctly. I would like to ask in what other parts of the code should I make corresponding changes to add the sdp data correctly.</div>  <div>&nbsp;</div>  <div>Thank you for your&nbsp;time and efforts.</div>  <div>&nbsp;</div>  <div>Arch Sayo</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>Hi Arch,<BR><BR>&gt; Thank you with that information on
  adding
 the 1284ID <BR>attribute.<BR><BR>you are welcome. I assume it is working perfect now.<BR> <BR>&gt; Now, I am trying to add the Additional Protocol <BR>Descriptor List to my<BR>&gt; sdp record. The Additional Protocol Descriptor List <BR>is almost similar<BR>&gt; to the Protocol Descriptor List. The only difference <BR>is that while the<BR>&gt; Protocol Descriptor List is a sequence of a sequence <BR>of data (2<BR>&gt; levels),&nbsp; the Additional Protocol Descriptor List is <BR>a sequence of a<BR>&gt; sequence of a sequence of data (3 levels) .I tried <BR>doing this using<BR>&gt; the function sdp_set_access_protos() and just <BR>substituting the<BR>&gt; Attribute ID in the function from <BR>SDP_ATTR_PROTO_DESC_LIST to<BR>&gt; SDP_ATTR_ADD_PROTO_DESC_LIST. However, as you may <BR>already know, this<BR>&gt; will not solve it since the Protocol Descriptor List <BR>is only a<BR>&gt; sequence of a sequence.<BR>&gt;&nbsp; <BR>&gt; In this regard, I would like to ask how I will be
 <BR>able to add a<BR>&gt; sequence of a sequence of a sequence of data to my <BR>sdp record. Or in<BR>&gt; other words, how will I add the Additional Protocol <BR>Descriptor List to<BR>&gt; my sdp record.<BR><BR>And again Collin already ran into the same problem, <BR>because you also<BR>need them for HID. So I think we need a <BR>sdp_set_add_access_protos()<BR>function for this job. Feel free to send me a patch.<BR><BR>Regards<BR><BR>Marcel<BR></div><p>
	
		<hr size=1>Yahoo! Shopping<br> 
Find Great Deals on Holiday Gifts at <a href="http://us.rd.yahoo.com/mail_us/footer/shopping/*http://shopping.yahoo.com/;_ylc=X3oDMTE2bzVzaHJtBF9TAzk1OTQ5NjM2BHNlYwNtYWlsdGFnBHNsawNob2xpZGF5LTA1 
">Yahoo! Shopping</a> 
--0-1249044936-1134545420=:77324--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
