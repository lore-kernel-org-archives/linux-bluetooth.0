Return-Path: <cyrus@holtmann.org>
Subject: Re: Is there any limit on the bluetooth share folder in linux
 either in bluez stack or in obex ftp?
From: Marcel Holtmann <marcel@holtmann.org>
To: Sasikiran Maddula <Madula.Sasikiran@Atheros.com>
Cc: johan.hedberg@gmail.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4AB0ACA9.8030102@Atheros.com>
References: <4AB086D3.9070706@Atheros.com> <20090916064933.GA28541@jh-x301>
	 <4AB0ACA9.8030102@Atheros.com>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 07:56:13 -0700
Message-Id: <1253112973.28416.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sasikiran,

> >> I tried to send a file of more than 2 GB using bluetooth in linux. It
> >> says "Error while copying. There is not enough space on the destination.
> >> Try to remove files to make space". When I look for more details it says
> >> "There is 2.0GB available, but 2.8GB required", but the file size I am
> >> trying to send is 2.8 GB, also in the other end it has more space than
> >> the file size. I am trying to copy the file from laptop1 to laptop2 with
> >> a share folder as "x" in laptop2. I used several vendor dongles. All of
> >> them behave the same way. When I check for the properties of folder x in
> >> laptop1 it shows as 2.0 GB used and 2.0 GB free. But actually the share
> >> folder is not filled by 2.0GB, but it is more. I used linux 2.6.28 and
> >> 2.6.31 kernel versions with bluez 4.32. I even verified with 2.6.31 with
> >> 4.32 bluez and 2.6.28 with 4.53 bluez. All of them behave the same way.
> >> Could some body suggest me where is the issue and how to rectify the
> >> issue.
> >>     
> >
> > BlueZ comes neither with an OBEX server nor an OBEX client. Which client
> > and server are you using? AFAIK by using standard OBEX FTP the only way
> > for the client to know the amount of free space in the server is through
> > the capability object. Maybe the capability object on server contains
> > false information or then your client is interpreting it incorrectly.
> >
> >   
> By default Linux comes with obex-data-server. I am using that itself. Do 
> you think I need to update that and try. If so can you tell me what 
> version has the fix.

neither from Johan or me you will get help on obex-data-server. We are
focusing on obexd and I don't remember it having any of these issues.

Regards

Marcel


