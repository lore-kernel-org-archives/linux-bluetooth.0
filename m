Return-Path: <cyrus@holtmann.org>
Message-id: <4928F261E93B4ADD83272E364EF54224@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <4ED4A576.8030102@globaledgesoft.com>
 <CABBYNZ+UP2o0-pL3FUAyrPeJi4JeNGR2Xj9DbB8FNWgYTyY9Tg@mail.gmail.com>
 <4ED4C45E.4090606@globaledgesoft.com>
In-reply-to: <4ED4C45E.4090606@globaledgesoft.com>
Subject: FTP file authorization and transfer progress support
Date: Tue, 29 Nov 2011 19:13:37 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Currently in OBEXD, only OPP put has authorization and file progress
indication. I am planning to implement the same in FTP put/get/delete the
same way as it does in OPP. But application may need to know the type of the
obex operation to which the Authorize method is invoked. So I am planning to
add a new method namely GetProperties in transfer, which returns the type of
the operation (put/get/delete) so that application can use it in Authorize
method. Please let me know your suggestions.

Thanks and Regards
Jaganath 

