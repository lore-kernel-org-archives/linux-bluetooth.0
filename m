Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Reducing input latency/lag on connected game controllers (On
 Raspberry Pi)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1bd86cc7-8d20-ba15-0cbe-9bda5d3e2327@gmail.com>
Date: Fri, 10 Feb 2017 12:38:29 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D2D2F604-A1D6-4DC8-833F-3A2D6BCAE503@holtmann.org>
References: <1bd86cc7-8d20-ba15-0cbe-9bda5d3e2327@gmail.com>
To: Alan Roxdale <alanroxdale@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Alan,

> Hello. I'm trying to come up with a permanent solution to reducing input lag/latency from connected bluetooth game controllers. The specific setup I'm looking at is a RetroPie 3 (inbuilt bluetooth) with a PS3 controller, but from preliminary investigations I believe that lag should be reducible in a wider class of set-ups and devices.
> To cut a long story short, as outlined in this forum thread -- https://retropie.org.uk/forum/topic/7712/fixing-dualshock-3-bluetooth-lag -- the input lag can apparently be substantially reduced by (manually) switching the controller's connection into slave mode. However this has to be done manually each time the controller is connected. Also, I'm am not sure why this is working. My knowledge of bluetooth is currently fairly low.
> 
> So I'm both looking for a more permanent automated solution and also a greater understanding of what is actually happening here.
> 
> My current process for measuring and reducing input-lag manually is as follows:
> 
> 
> 1) Determine controller IP
> 
> $ hcitool con
> 
> Produces output like (I have only the controller itself connected)
> 
> Connections:
> > ACL AA:BB:CC:DD:EE:FF handle 11 state 1 lm MASTER
> 
> 2) Determine latency with l2ping  (Turning off wifi also reduces this latency substantially on the Raspberry Pi at least)
> 
> $ sudo l2ping AA:BB:CC:DD:EE:FF
> 
> 4 bytes from AA:BB:CC:DD:EE:FF id 0 time 13.70ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 1 time 36.19ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 2 time 34.83ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 3 time 36.08ms
> 
> I presume that to use l2ping to determine latency times, one divides by two. So the controller has a quasi consistent latency of (I assume) ~ 18ms. I believe this delay is being set by the (PS3) controller.
> 
> 
> 3) Reducing latency by switching to slave mode using hcitool sr
> 
> For reasons I do not fully understand, on the Pi, switching the controller's connection to slave mode reduces input lag further. These are the steps I take.
> 
> $ sudo hcitool sr AA:BB:CC:DD:EE:FF slave
> 
> $ hcitool con
> Connections:
>    > ACL AA:BB:CC:DD:EE:FF handle 11 state 1 lm SLAVE
> 
> $ sudo l2ping AA:BB:CC:DD:EE:FF
> Ping: AA:BB:CC:DD:EE:FF from 00:11:22:33:44:55 (data size 44) ...
> 4 bytes from AA:BB:CC:DD:EE:FF id 0 time 13.81ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 1 time 11.28ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 2 time 12.32ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 3 time 12.29ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 4 time 12.27ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 5 time 12.14ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 6 time 12.36ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 7 time 12.26ms
> 4 bytes from AA:BB:CC:DD:EE:FF id 8 time 12.27ms
> 
> I presume this means that the controller latency is now a fairly consistent. ~6-7ms. Apparently this is the lowest latency possible (from something called "SNIFF MODE"?).
> I can report that subjectively input lag is substantially reduced by this step, and I believe these lowered pings do translate into actual reduction in objective input lag. But I have no direct way of measuring this.
> 
> So my question is twofold:
> 
> A) How can I set up the bluetooth/hci0/??? connection settings so that the connected controllers are permanently in slave mode? (Something in /etc/bluetooth ?)
> B) What exactly is going on here and how are input latency/lag settings actually determined in the bluetooth standard? Again, is there a way of reducing input lag for all such devices? (possibly to below 6ms?)
> 
> ======
> 
> My reason for asking question B) is that, as can be seen in the linked forum thread, this quick hack of switching to slave mode isn't working for all controller types. Newer controller modes enter AUTH and ENCRYPT modes and/or won't allow role switching.
> 
> What I suspect is going on here is that the controllers, which are pressed to initiate the bluetooth connection, connect as the master in the connection, but each on their own terms. Strangely their connection parameter seem to include very long (SNIFF mode?) delays and things like encryption, authentication which I would presume would increase lag. Is there any way of setting up the bluetooth (hci0) device on the Pi so that it overrides the controllers' default settings and produces a connection with the lowest possible latency on all devices?

are you actually stuck in sniff mode? We are not always taking the device out of sniff mode. Sniff mode still allows for data transmission, just with a horrible latency. Run btmon and check if HCI_Mode_Changed events occur.

Regards

Marcel

