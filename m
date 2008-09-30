Return-Path: <cyrus@holtmann.org>
Message-ID: <48E1DCA8.2040005@dtsp.co.nz>
Date: Tue, 30 Sep 2008 21:00:40 +1300
From: David Sainty <David.Sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: Mario_Limonciello@Dell.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Make bluetooth-properties fit on smaller displays
References: <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>	 <1222679240.1825.14.camel@violet.holtmann.net>	 <1222679724.3311.53.camel@cookie.hadess.net>	 <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com> <1222701730.3311.76.camel@cookie.hadess.net>
In-Reply-To: <1222701730.3311.76.camel@cookie.hadess.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> On Mon, 2008-09-29 at 10:05 -0500, Mario_Limonciello@Dell.com wrote:
>   
>> Hi Bastien & Marcel:
>>
>> Here's the screenshots as requested:
>>
>> Old: http://imagebin.org/27644
>>
>> New: http://imagebin.org/27643
>>
>> A lot of these MID devices don't have screens bigger than 1024x600
>> (some 800x600 depending on their aspect ratio).  This change really
>> just reorganizes the GUI so that both laptops and MID devices can use
>> the same layout.  I'm attaching an updated patch relative to 1.6.
>>     
>
> Both versions would fit on both those screens. What's wrong with leaving
> it as is? In the worst case, I'd move the contextual buttons to the side
> of the treeview, instead of underneath, and add labels to those buttons.
>   
The preferences dialog on an Eee PC (701) screen is a real pain, it is 
too big vertically.  800x480 screen, plus a window manager bar at the 
bottom, plus some chunky window decorations up the top.  For a window to 
fit conveniently on a standard Eee PC screen it needs to be 422 pixels 
vertically it looks like (the standard decorations are VERY chunky :)
