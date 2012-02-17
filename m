Return-Path: <cyrus@holtmann.org>
Message-ID: <1329468785.28848.143.camel@aeonflux>
Subject: RE: [PATCH] LMP transaction collision at Set encryption
From: Marcel Holtmann <marcel@holtmann.org>
To: "Mohanan, Rajmohan" <rajmohan.mohanan@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 17 Feb 2012 09:53:05 +0100
In-Reply-To: <E74476E55D15D942BA0FF3CDAD73606F043646@FMSMSX102.amr.corp.intel.com>
References: <LMP Transaction collision>
	 <1329209821-2783-1-git-send-email-rajmohan.mohanan@intel.com>
	 <1329308999.28848.89.camel@aeonflux>
	 <E74476E55D15D942BA0FF3CDAD73606F043646@FMSMSX102.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rajmohan,

please refrain from top-posting on the mailing list. Please do inline
quoting.

>       In Lmp transaction collision happens at set encryption request ,
>      if encrypt change event with status code " LMP transaction collision "comes and will start the disconnection procedure.
>      If encryption change event with success(Master initiated)  comes with in 10 millisecond, then conn->refcount will go to a negative   value(because hci_conn_put is calling and it will decrement the reference count which was zero already  in the previous error response). At this time disconnection won't happen but the reference count value went to negative which will make the timer operations in a bad state. I have faced this issue two times.
> 
> If I'm misunderstood please correct me.
> 
> So the patch  solves this issue also.

Please reply to patches properly. I have not idea what the above
statement has to do with my review.

Regards

Marcel


