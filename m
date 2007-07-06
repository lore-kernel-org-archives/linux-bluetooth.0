Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <468E76DD.6070303@free.fr>
Date: Fri, 06 Jul 2007 19:07:41 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46852386.8050608@free.fr>	<2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>	<d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>	<1183514223.6351.56.camel@aeonflux.holtmann.net>	<468CE233.8000909@free.fr>	<d89ddf300707050940n7ffece6cs2ec5836def9e3ae9@mail.gmail.com>	<468DF298.5010205@free.fr>	<2d5a2c100707060612g6ed3a543g9f36b6db49a97a95@mail.gmail.com>	<468E446A.1000204@free.fr>
	<468E46E5.2050206@access-company.com>
	<2d5a2c100707060801s413d8bdclb0b25a4f5a340773@mail.gmail.com>
In-Reply-To: <2d5a2c100707060801s413d8bdclb0b25a4f5a340773@mail.gmail.com>
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Luiz Augusto von Dentz wrote:
> Hi again,
> 
> On 7/6/07, Frederic Dalleau <frederic.dalleau@access-company.com> wrote:
>>> You need the power of Gstreamer in order to stream MP3 directly to the
>>> headset : you need a native Gstreamer bluetooth element.
>>>
>> In a desktop situation, you will want to mix streams this is not
>> possible using mp3.
>> Lots of a2dp devices do not handle mp3. And what if your music is not
>> mp3 encoded, say ogg?
> 
> Yep, but Fabien probably mean that we gain more flexibility by having some
> native elements on gstreamer, and I agree with that. 
> One of the problems
> that Im afraid of is the plugin having to handle encoding/decoding by it own

In my opinion the native elements wouldn't do any encoding/decoding 
work: this is clearly GStreamer Job as a media converting framework.
I think we would have to:
   - extend the already included RTP GStreamer element to accept sbc and 
mp3 encoded streams.
   - wrap libsbc into a GStreamer element to do convert to do PCM to sbc.
   - create an a2dp Gstreamer element

..and that's all...
Then any enabled GStreamer application would be able to natively stream 
mp3, or stream whatever other format using sbc. :-)

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
