Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A286798B34C0C9419EDBB5F44D457E1413D2D6@SHSMSX101.ccr.corp.intel.com>
References: <A286798B34C0C9419EDBB5F44D457E14137231@SHSMSX101.ccr.corp.intel.com>
	<CAJdJm_OO4SXo6sSCnuoCWYB2nvhHjWp=gPwY9bAjPRYij2UAmA@mail.gmail.com>
	<A286798B34C0C9419EDBB5F44D457E1413D2D6@SHSMSX101.ccr.corp.intel.com>
Date: Sun, 7 Apr 2013 11:01:19 -0400
Message-ID: <CAJdJm_MHao8QLnHMq_UXPPmiUBbxzDZy9vALuFPM=e+r+66umw@mail.gmail.com>
Subject: Re: one question on BLE device authentication error
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Huang, Christina" <christina.huang@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christina,

On Sun, Apr 7, 2013 at 2:23 AM, Huang, Christina
<christina.huang@intel.com> wrote:
>
> Hi, Anderson
>
> I met one more issue on connecting with Wahoo BlueSC BLE speed / cadence sensor device, it could be discovered successfully, while fails in connection and reports error " Command Disallowed ". Could you suggest what I could do to allow the "connect" command?
> I found this same issue reported before but no available answer.
> http://www.spinics.net/lists/linux-bluetooth/msg30681.html

How are you doing the device discovery? You should use the BlueZ D-Bus
API instead of "hcitool lescan", because some (most?) BLE controllers
do not allow connection creation while in LE scanning state. If I
remember correctly, If the D-Bus API is always used the LE scan is
always disabled prior to LE Create Connection.

Also make sure you are not in advertising state (i.e. you did not run
"hciconfig hci0 leadv").

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
