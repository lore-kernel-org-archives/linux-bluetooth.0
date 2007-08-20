Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100708201111s5d73b6b6qdbef9c399cb3b3a7@mail.gmail.com>
Date: Mon, 20 Aug 2007 15:11:35 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46C9D2E0.5050404@free.fr>
MIME-Version: 1.0
References: <46C875BA.90204@free.fr>
	<2d5a2c100708191902k599014cbo1e08c9c7a3febd45@mail.gmail.com>
	<46C9D2E0.5050404@free.fr>
Subject: Re: [Bluez-devel] [PATCH] pcm_bluetooth : fix a2dp streaming
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien,

On 8/20/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
> Hi Luiz,
>
> Please find a few remarks below:
>
> > I got almost the same idea implemented in my git
> > (git://git.infradead.org/users/vudentz/bluez-utils.git).
>
> Should make sense then :-)
>
> There is
> > alot of simplification you already did, but I consider the
> > bitrate as a2dp spec says.
>
> Oh... about this bitrate stuff i must say i'm quite confused : where did
> you find anything in the spec ? (I have A2DP 1.0 but didn't find
> anything :-( )

Spec 1.2 is already available, but even in it is difficult to find as it is
in Appendix part 12.9 page 66. Im not sure if the rate is mandatory
or not, but as we have some headsets surfer from speed problem
it might be a rate issue.

> > I also implement a circular
> > buffer for encoded sbc frames to be consumed by a
> > thread.
>
> That was another option, however it was not that clear what the benefits
> from it would be, so i took the easiest to implement alternative, and
> just sent data as they arrived ;-)

It seems it is not always the case we are ready to send right away,
this is what Im trying to figure out since the buffer sometimes got
full (encoding process is too fast) or even (weird) I got no frames
to sent on time thread (encoding too slow).

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
