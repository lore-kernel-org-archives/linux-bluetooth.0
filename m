Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 May 2010 09:08:59 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<jcaden@libresoft.es>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Data transmission and reconnections in HDP
Message-ID: <20100507120859.GD12461@vigoh>
References: <201005071302.36198.jcaden@libresoft.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201005071302.36198.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi José,

* José Antonio Santos Cadenas <jcaden@libresoft.es> [2010-05-07 13:02:36 +0200]:

> Hi all,
> 
> I start this thread to discuss the alternatives to move the data from the 
> application to the l2cap socket in HDP. Till now we have the following 
> alternatives (please, add more if we missed something)
> 
> Reconnections options:
> 
>  Option 1: Implicit reconnections: The application is not concern about the 
> disconnections or reconnections of the data channel until it is deleted.
> 
> 	We prefer this option because fixes more with a manager philosophy. A 
> 20601 manager sould not perceive temporal disconnections because this way can 
> hold it state if it perceives a disconnection, next time it reconnects it will 
> need to exchange again apdus for association.
> 
>  Option 2: Reconnections by the application. The applications are notified when 
> a data channel is disconnected and should perform a reconnection before using 
> it again.
> 
> Data transmission options:
> 
>  Option 1: Fd_passing the l2cap socket of the data channel to the client. The 
> problem with this is that some data can be lost by d-bus if the channel is 
> disconnected. (We have to check how fd-passing works).

DBus just pass the fd and then don't touch the fd anymore, data can't be
lost by DBus.

> 
>  Option 2: Fd_passing a pipe and HDP will write the data in the l2cap data 
> chanel socket. The problem with this is that we need 2 pipes for each data 
> channel, but no data will be lost because HDP controls the data flow with the 
> sockets and resend data not correctly sent.
> 
> 	We think that the easier way for implicit reconnections is option 2. 
> Because the application can always write on the socket it have (the pipe). 
> Once written, the HDP layer tries to write it in the l2cap socket, if it 
> fails, perform a reconnection operation over the data channel.
> 
>  Option 3: Transmiting the data by d-bus. We think that this option is bad for 
> d-bus, because of the overload of the system bus.

Pretty bad ;)

> 
>  Option 4: Other IPC alternatives (more alternative here?)
> 
> Regards.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
