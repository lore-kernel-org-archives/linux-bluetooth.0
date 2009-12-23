Return-Path: <cyrus@holtmann.org>
Message-ID: <4B31F893.6030009@videam.com.br>
Date: Wed, 23 Dec 2009 09:01:39 -0200
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

Hi Venu:

Thanks for replying.

Indeed, the reconnection is always successful, and, once it reconnects, 
the mouse works well, without any lag or other issues. The whole problem 
is the 4 second delay that happens during reconnection (see the last two 
timestamps in the hicdump), making the overall process take about 5 
seconds, which is a lot to wait every time you need to awake the mouse 
from sleep mode.

Since the delay takes place right after the remote name request, I 
wonder if that may have something to do with it, and if a solution might 
be to not request again the name of a device that was previously 
connected, and is merely coming out of sleep mode. (This is just a 
guess, as I am not familiar with the Bluetooth protocol.) If you can 
suggest how I may provide more information that would help ascertain the 
cause of the delay (other hcidump flags, perhaps?), please let me know.

Regards,

Daniel

