Return-Path: <cyrus@holtmann.org>
Message-ID: <514AF43F.8030001@gmail.com>
Date: Thu, 21 Mar 2013 12:51:27 +0100
From: Sergio Callegari <sergio.callegari@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Kernel panic on kernel 3.8.x when closing bluetooth dun connection
References: <51498CFE.9060804@gmail.com> <20130320161712.GA27840@kroah.com>
In-Reply-To: <20130320161712.GA27840@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is just a short note to let you know that 3.8.x panics on closing a 
bluetooth dun connection.

This is seen with the ubuntu /mainline/ kernel 3.8.0 and 3.8.2 that should 
vanilla kernels with no ubuntu tweaking.

Observed on a DELL E6500 which has BCM2046 Bluetooth while connecting to the
internet using a Samsung Galaxy S mobile phone via bluetooth DUN through the 
network manager.  When network manager is asked to close the connection, the 
kernel panics, the system drops out of Xorg, shows for a couple of seconds a 
long log including the words 'panic' and 'not synching', the numlock, caps-lock 
keys start flashing and the system freezes.

It is 100% repeatable.

kernels 3.7.0 and 3.7.8 do not panic.

Thanks for the attention and best regards,

Sergio Callegari
