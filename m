Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1133429978.1037.22.camel@panic>
Mime-Version: 1.0
Subject: [Bluez-devel] sdp seq of raw data
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
Date: Thu, 01 Dec 2005 01:39:38 -0800

Hi Marcel and list,

I'm trying (for hours now) to put a raw binary string into a sdp
attribute so that it shows up like this:

---8<----
Data Sequence
      Data : 0B 0X 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01
95 08 81 02 75 08 95 01 81 01 75 01 95 05 
05 08 19 01 29 05 91 02 75 03 95 01 91 01 75 08 95 06 15 00 26 ff 00 05 
------>8------

I have tryed two methods, both failed:

SEQ8 method:

unit8_t h_spec[] = { binary_crap };
uint8_t dtd2 = SDP_UNIT8;
uint8_t dtd_data = SDP_SEQ8;
void *dtds[2];
void *values[2];


// this is a other uint8 value which gets placed correctly
dtds[0] = &dtd2;
values[0] = &h_spec_leng;

for (i = 0; i < sizeof(h_spec); i++) {
 h_spec_data_lst[i] = sdp_data_alloc(dtd2, &h_spec[i]);
 h_spec_data_dtds[i] = &dtd_data;
}
// sometimes it crashes here...
h_spec_data_list = sdp_seq_alloc(h_spec_data_dtds, 
  (void**)h_spec_data_lst, sizeof(h_spec));

dtds[1] = &dtd_data;
values[1] = h_spec_data_list;
// sometimes it crashes here
h_spec_lst = sdp_seq_alloc(dtds, values, 2);
sdp_attr_add(sdp_record, SRV_ATTR_1, h_spec_lst);

// and sometimes the attributes added after this one don't get
displayed, and the binary string is only one byte long


TEXT_STR8 method:

works fine but can't use binary, because of strcpy/strlen in sdp part of
libbluetooth


I couldn't find any matching example in all the BlueZ code...

thanks ... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
It's a hardware problem!



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
