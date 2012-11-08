Return-Path: <cyrus@holtmann.org>
Message-ID: <509BD103.2040808@elbrys.com>
Date: Thu, 08 Nov 2012 10:34:27 -0500
From: Bart Westgeest <bart@elbrys.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Feedback on potential fix for issue while advertising Feature List
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi folks,

I've tracked down the root cause of an issue, and am looking for 
input/feedback on what the acceptable/preferred fix is.

The code of interest is in sdp_set_supp_feat. The bug is exposed by 
registering a feature list (SDP_ATTR_SUPPORTED_FEATURES_LIST) of a 
length greater than 256. The attribute sequence type in one of the 
resulting attribute sequences is hard-coded to be SDP_SEQ8. When the 
list grows beyond 256 bytes, the size descriptor type is not corrected 
to SDP_SEQ16.

Henceforth, the indicated size of this attribute sequence in an SDP 
response PDU is whatever the lower byte of the feature list size is. 
However, the complete list data is written in the SDP response, hence 
forming a corrupted PDU.

This bug can easily be reproduced by registering a number of Health 
Applications (including a description string) such that the size of the 
advertised feature list attribute is greater than 256 bytes. 
Subsequently querying for this SDP record with sdptool, will result in 
indicated errors about unknown data due to parsing errors.

The quick and dirty fix is to change the return statement in 
sdp_seq_alloc (lib/sdp.c:563) from:
	return sdp_data_alloc(SDP_SEQ8, seq);
to
	return sdp_data_alloc(SDP_SEQ16, seq);

However, it really looks like the data type should be determined 
dynamically, or perhaps (a more involved fix,) instead of using nested 
data sequences for the outer data type, perhaps it should be changed to 
a list i.e. to use sdp_list_t instead sdp_data_t for the feature list.

In addition, this problem (hard coded sequence length for a variable 
length list) seems be repeated at various places throughout the code, so 
this problem does not appear to be isolated to sdp_set_supp_feat/HDP. 
For example sdp_set_lang_attr, sdp_set_uuidseq_attr, and 
sdp_set_profile_descs all appear to form corrupted PDU if their 
specified list grows beyond 256.

I appreciate any input from anybody more familiar with the SDP code on 
what the accepted/preferred approach is to get this issue fixed.

Thanks,
Bart
