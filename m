Return-Path: <cyrus@holtmann.org>
Message-ID: <4E79E3EC.20200@tieto.com>
Date: Wed, 21 Sep 2011 15:17:32 +0200
From: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth: Add secure flag for mgmt_pin_code_req
References: <20110921070804.GA5982@elgon.mountain>
In-Reply-To: <20110921070804.GA5982@elgon.mountain>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> dereferenced unconditionally here.
>
>    2190				secure = 1;
>    2191			else

Obviously, will sent a patch in a while.

Thanks,
/Waldek
