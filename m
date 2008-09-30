Return-Path: <cyrus@holtmann.org>
Message-ID: <48E2A4D5.8020509@dtsp.co.nz>
Date: Wed, 01 Oct 2008 11:14:45 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Mario_Limonciello@Dell.com
CC: marcel@holtmann.org, hadess@hadess.net,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Make bluetooth-properties fit on smaller displays
References: <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>	 <1222679240.1825.14.camel@violet.holtmann.net>	 <1222679724.3311.53.camel@cookie.hadess.net>	 <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>	 <1222701730.3311.76.camel@cookie.hadess.net>  <48E1DCA8.2040005@dtsp.co.nz> <1222762649.1825.56.camel@violet.holtmann.net> <48E1E9D3.8050202@dtsp.co.nz> <FA7963CC89065B49AED46A6F797F0FA6F2869C@AUSX3MPC128.aus.amer.dell.com>
In-Reply-To: <FA7963CC89065B49AED46A6F797F0FA6F2869C@AUSX3MPC128.aus.amer.dell.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

xdpyinfo says the DPI is 100x101... heh...

  dimensions:    800x480 pixels (203x121 millimeters)
  resolution:    100x101 dots per inch

In reality it's around 133dpi (153mm x 92mm).


Mario_Limonciello@Dell.com wrote:
> Hi Folks:
>
> I would think the DPI of the environment is playing into this.  David, what DPI is on your EEE?
>
> Regards
>
> Mario Limonciello 
> Dell | Linux Engineering 
> Mario_Limonciello@Dell.com 
>
>
>
> -----Original Message-----
> From: David Sainty [mailto:david.sainty@dtsp.co.nz]
> Sent: Tue 9/30/2008 3:56 AM
> To: Marcel Holtmann
> Cc: Bastien Nocera; Limonciello, Mario; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Make bluetooth-properties fit on smaller displays
>  
> Marcel Holtmann wrote:
>   
>> Hi David,
>>
>>   
>>     
>>>>> A lot of these MID devices don't have screens bigger than 1024x600
>>>>> (some 800x600 depending on their aspect ratio).  This change really
>>>>> just reorganizes the GUI so that both laptops and MID devices can use
>>>>> the same layout.  I'm attaching an updated patch relative to 1.6.
>>>>>     
>>>>>         
>>>>>           
>>>> Both versions would fit on both those screens. What's wrong with leaving
>>>> it as is? In the worst case, I'd move the contextual buttons to the side
>>>> of the treeview, instead of underneath, and add labels to those buttons.
>>>>   
>>>>       
>>>>         
>>> The preferences dialog on an Eee PC (701) screen is a real pain, it is 
>>> too big vertically.  800x480 screen, plus a window manager bar at the 
>>> bottom, plus some chunky window decorations up the top.  For a window to 
>>> fit conveniently on a standard Eee PC screen it needs to be 422 pixels 
>>> vertically it looks like (the standard decorations are VERY chunky :)
>>>     
>>>       
>> the dialog ix 420x420 and thus it should fit.
>>   
>>     
> Interesting - that's not what I'm seeing.  I've just tried xwininfo on 
> bluez-gnome-1.7 on both an Eee PC and a full sized PC (possibly with 
> slightly different support library versions).
>
> Full sized PC geometry for the preferences window is 420x521.  EeePC 
> geometry for the same is 420x523.
>   I'm not sure where the 2 pixel difference comes from (I don't think 
> the geometry here is including the window manager decorations).  But 
> neither are close to 420x420.  You weren't thinking 420x520 perchance?
>
>   


