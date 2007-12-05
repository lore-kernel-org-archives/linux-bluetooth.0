Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W42E87B159ECF6B4624FBFCC06E0@phx.gbl>
From: "" <semiyd@hotmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 5 Dec 2007 07:40:59 +0000
In-Reply-To: <1196839211.12292.147.camel@violet>
References: <BAY117-W17E4F36814D533D4CCFA00C06E0@phx.gbl>
	<1196839211.12292.147.camel@violet>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Does bluez support SCO audio over PCM as
	well	as	HCI?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2047392916=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2047392916==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Marcel:
        thanks, that reminds me.  It's configured in audio.conf.
        I'll try that out after i connected my bluetooth chip to CPU through PCM interface.
        

Best Regards


semiyd


> From: marcel@holtmann.org
> To: bluez-users@lists.sourceforge.net
> Date: Wed, 5 Dec 2007 08:20:11 +0100
> Subject: Re: [Bluez-users] Does bluez support SCO audio over PCM as well as HCI?
>
> Hi,
>
>> The current bluez supports sco audio channel over hci to do HSP,HFP.
>> But I have a ST2500c bluetooth chip and it only supports SCO over PCM. That means, i'll have to connect my CPU(ARM9)'s PCM interface to the ST2500C bluetooth chip's PCM interface .And the audio data is transfered by PCM not HCI after sco channel is established(correct me if im wrong) .
>> Does bluez support such a function?
>> If it doesn't , maybe i should do some coding like : establishing sco connection..... transfer data through PCM interface....etc. Is that right?
>
> the audio service has an option to do PCM routing. It is used in the
> Nokia N800 and N810. So it is perfectly supported.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> SF.Net email is sponsored by: The Future of Linux Business White Paper
> from Novell. From the desktop to the data center, Linux is going
> mainstream. Let it simplify your IT future.
> http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Spaces. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us


--===============2047392916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============2047392916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2047392916==--
