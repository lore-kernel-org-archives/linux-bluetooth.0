Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB0ACA9.8030102@Atheros.com>
Date: Wed, 16 Sep 2009 14:45:21 +0530
From: Sasikiran Maddula <Madula.Sasikiran@Atheros.com>
MIME-Version: 1.0
To: <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Is there any limit on the bluetooth share folder in linux	either
 in bluez stack or in obex ftp?
References: <4AB086D3.9070706@Atheros.com> <20090916064933.GA28541@jh-x301>
In-Reply-To: <20090916064933.GA28541@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg wrote:
> Hi,
>
> On Wed, Sep 16, 2009, Sasikiran Maddula wrote:
>   
>> I tried to send a file of more than 2 GB using bluetooth in linux. It
>> says "Error while copying. There is not enough space on the destination.
>> Try to remove files to make space". When I look for more details it says
>> "There is 2.0GB available, but 2.8GB required", but the file size I am
>> trying to send is 2.8 GB, also in the other end it has more space than
>> the file size. I am trying to copy the file from laptop1 to laptop2 with
>> a share folder as "x" in laptop2. I used several vendor dongles. All of
>> them behave the same way. When I check for the properties of folder x in
>> laptop1 it shows as 2.0 GB used and 2.0 GB free. But actually the share
>> folder is not filled by 2.0GB, but it is more. I used linux 2.6.28 and
>> 2.6.31 kernel versions with bluez 4.32. I even verified with 2.6.31 with
>> 4.32 bluez and 2.6.28 with 4.53 bluez. All of them behave the same way.
>> Could some body suggest me where is the issue and how to rectify the
>> issue.
>>     
>
> BlueZ comes neither with an OBEX server nor an OBEX client. Which client
> and server are you using? AFAIK by using standard OBEX FTP the only way
> for the client to know the amount of free space in the server is through
> the capability object. Maybe the capability object on server contains
> false information or then your client is interpreting it incorrectly.
>
> Johan
>   
By default Linux comes with obex-data-server. I am using that itself. Do 
you think I need to update that and try. If so can you tell me what 
version has the fix.

Thanks,
Sasikiran.
