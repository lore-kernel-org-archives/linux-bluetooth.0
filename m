Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E1179670E@SHSMSX104.ccr.corp.intel.com>
References: <1380008221-30501-1-git-send-email-wu.zheng@intel.com>
	<2CF57A644018A745B8FE029C7223E16E1179670E@SHSMSX104.ccr.corp.intel.com>
Date: Sun, 29 Sep 2013 11:38:19 +0300
Message-ID: <CABBYNZK_MgN6BZ8RS_pn5OL=GTeawzo6crRy_dsT3EdrCWUacg@mail.gmail.com>
Subject: Re: FW: [PATCH 1/2] obexd:Add Operation property to transfer properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
	"Hedberg, Johan" <johan.hedberg@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Sep 29, 2013 at 6:03 AM, Zheng, Wu <wu.zheng@intel.com> wrote:
> Hi Luiz,
>
> Can you help review the patches? Thanks

First, please do not top post.

> Best Regards
> Zheng Wu
>
>>-----Original Message-----
>>From: linux-bluetooth-owner@vger.kernel.org
>>[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Wu Zheng
>>Sent: Tuesday, September 24, 2013 3:37 PM
>>To: linux-bluetooth@vger.kernel.org
>>Cc: Zheng, Wu
>>Subject: [PATCH 1/2] obexd:Add Operation property to transfer properties
>>
>>Sometime, operation property is needed by the Bluetooth APP.
>>Therefore, add the property to transfer properties
>>---

You probably need to work on to why we need such property, I have no
idea what you are reference to a Bluetooth APP, obviously is not the
application that have created the transfer since that know should know
what operation will be used.

If this is for some kind of download manager application that you are
talking about Im not sure why it would like to know the operation? Is
that to display the direction? Im not really sure this will be
convenient for a download manager but I would not expose the operation
itself probably upload/download or add new status
uploading/downloading.



-- 
Luiz Augusto von Dentz
