Return-Path: <cyrus@holtmann.org>
Message-ID: <4B32351F.2010907@videam.com.br>
Date: Wed, 23 Dec 2009 13:19:59 -0200
From: "Daniel T. Cobra" <dcobra@videam.com.br>
MIME-Version: 1.0
To: venu <vjosyula@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>	 <4B2A4B90.1040009@videam.com.br> <4B2BBF58.4030901@videam.com.br>	 <1261173899.4041.96.camel@localhost.localdomain>	 <1261176544.4b2c06e0e0eae@www.fastmail.com.br>	 <1261177111.4041.99.camel@localhost.localdomain>	 <1261185699.4b2c2aa37a9c4@www.fastmail.com.br>	 <4B30B555.5000202@videam.com.br> <4B30B6FF.4090300@videam.com.br> <53ea87da0912222033y530c83dci41bb6d9b99ece6c@mail.gmail.com>
In-Reply-To: <53ea87da0912222033y530c83dci41bb6d9b99ece6c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vanu:

Thanks for your suggestion. However, isn't there a better way? I don't 
know the HID specification, but I imagine it should probably foresee the 
possibility of not repeating the remote name request when you need fast 
reconnection. Isn't there an operating mode, configuration option, 
whatever, that would do this without the need to modify bluez' code? I'd 
like to make sure there is really no better alternative, before going 
down this path. What do you think?

Regards,

Daniel


venu wrote:
> Hi Daniel,
>
> Actually you are right, it can directly do read remote features 
> without doing a remote name request, as the connection already exists.
>
> Why dont you run a small experiment. Find the place in the code which 
> sends HCI Command to do a remote name request and comment that piece 
> of code if the HID Connection exists and then try reconnecting i.e.
> 1. Make the above changes to the code.
> 2. Pair your hid as well as establish HID Connection.
> 3. While doing get the HCI DUMP again, this time you should not see 
> any HCI Command for remote name request.
>
> I sure , you should see improvement in the reconnection timing, as a 
> side note if you have any hci tracer for windows you can capture the 
> HCI Traces as you have caputred above and compare them too, that will 
> give you clues what exactly is happening.
>
> Cheers,
> Venu

