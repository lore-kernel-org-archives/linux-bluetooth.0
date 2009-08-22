Return-Path: <cyrus@holtmann.org>
Subject: Re: Question about the connect Function and BlueZ.
From: Marcel Holtmann <marcel@holtmann.org>
To: "Abraham J. Velez (EndoraSoft)" <ajvelez@endorasoft.es>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <508DFE744C1A4696B3D22CA7ED563C35@TSESUO>
References: <508DFE744C1A4696B3D22CA7ED563C35@TSESUO>
Content-Type: text/plain
Date: Sat, 22 Aug 2009 12:59:24 -0700
Message-Id: <1250971164.2950.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Abraham,

> Well, we have a problem in the Linux platfform with BlueZ. The problem is 
> easy to explain:
> 
> We open a connexion (with bluetooth) with connect function (we use socket). 
> Every connexion make in his own thread. This connexions are with Obex Push 
> profile. This works without problems.
> 
> For the purposes of our applications, we need to cut this connection before 
> the terminal (reduced the time of the ask in the terminal: the user confirm 
> the sending). The call to connect function is blocking (because we need to 
> know if the user of the terminal can not connect errno==ECONNREFUSED).
> 
> 
> -------------------------------------------------------------------------------------------------------------------------------------------------------------
> fcntl(func->handlesocket, F_SETFL, fcntl(func->handlesocket, F_GETFL,0) & 
> ~O_NONBLOCK);
> func->refused = false;
> error = connect(func->handlesocket, (struct sockaddr *)&rem_addr, 
> sizeof(rem_addr));
> if(error<0)
>   {
>     if(errno==ECONNREFUSED) func->refused = true;
>     func->SetEvent(DIOLNXBTFSMEVENT_DISCONNECTING);
>     break;
>   }
> ------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
> The problem is: How cancel this block connexion make with connect function?
> 
> If we call to this code (in other thread) the connect function waits to 
> timeout of the terminal...

the problem seems similar or the same to what Nick posted a view weeks
ago. If you use blocking connect() in one thread the close() in another
thread will not terminate the connection attempt. As far as I can tell
this is true and should be fixed. It however works fine if you just
would use proper non-blocking connect() with a mainloop.

Regards

Marcel


