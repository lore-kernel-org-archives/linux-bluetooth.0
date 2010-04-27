Return-Path: <cyrus@holtmann.org>
Subject: SDP comments
From: Santiago Carot Nemesio <scarot@libresoft.es>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1272375578.2157.22.camel@mosquito>
References: <1272375265.2157.17.camel@mosquito>
	 <1272375425.2157.20.camel@mosquito>  <1272375578.2157.22.camel@mosquito>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 15:51:07 +0200
Message-ID: <1272376267.2157.29.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
It may be interesting to take in mind that some functions in sdp_lib
such as sdp_list_append or sdp_list_insert_sorted can return NULL if
there isn't enought memory. Grepping the code i saw sentences like next:
...
ap = sdp_list_append(ap, pds);
...
I think that it can result in a memory leak when the asignation return
NULL over a not empty list. What do you think?

Regards.

