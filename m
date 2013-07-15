Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY156-DS130EEED4C751697104CA1EB1670@phx.gbl>
From: "buyun" <shyboysby@hotmail.com>
To: "wei junping" <junping.wei@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
References: <CAKCXgJ1AiOJJjWZ96-v_MJ+cNsGg4w8BE--d4qbECH67c2g69Q@mail.gmail.com>
In-Reply-To: <CAKCXgJ1AiOJJjWZ96-v_MJ+cNsGg4w8BE--d4qbECH67c2g69Q@mail.gmail.com>
Subject: Re: BlueZ user space log on Android
Date: Mon, 15 Jul 2013 11:26:01 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="windows-1252";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,
To enable ADB trace, you need route the log to ADB by modifying log.h.
Best regards
Buyun
-----Original Message----- 
From: wei junping
Sent: Monday, July 15, 2013 10:34 AM
To: linux-bluetooth@vger.kernel.org
Subject: BlueZ user space log on Android

Hi,



Can anyone tell me how to enable BlueZ user space log on Android?

I found that there were a lot of DBG to output debug message, but
didn’t found anything related when run adb shell logcat.



Thank you and Best Regards,

Tim Wei
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

