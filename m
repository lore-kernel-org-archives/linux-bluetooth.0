Return-Path: <cyrus@holtmann.org>
Message-Id: <FA1352D8-03D2-4979-99A4-5EFE5EB8872E@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1223766202.31961.868.camel@cookie.hadess.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Fix possible crash on startup
Date: Sun, 12 Oct 2008 21:15:22 +0300
References: <1223766202.31961.868.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

Thanks for the patch. It has been pushed upstream. However, now that I  
looked at the code in question there are several things I have to  
wonder about:
1. Why is the code using sdp_data_get(rec, SDP_SERVER_RECORD_HANDLE)  
instead of rec->handle?
2. Is having the record really mandatory for allowing a device to  
connect? I.e. could we somehow make input_probe() work even if the  
record isn't available?

I think it was either Claudio or Luiz who has been touching this part  
of bluez code recently (at least git-blame shows Claudio being  
responsible for the SDP_SERVER_RECORD_HANDLE thing) so maybe they can  
shed some more light on these issues?

Johan


