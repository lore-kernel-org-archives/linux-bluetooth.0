Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Jerky MX900 mouse movement with 2.6.7-mh1, hidp and hidd
References: <1087757523.839.10.camel@pc.vesuri.net> <1087770579.4781.59.camel@pegasus> <1087763282.1232.17.camel@pc.vesuri.net>
In-Reply-To: <1087763282.1232.17.camel@pc.vesuri.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406202236.32282.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 20 Jun 2004 22:36:31 +0200

edit your hcid.conf  and modify:

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp hold,sniff,park,rswitch;

Michal


On Sunday 20 of June 2004 22:28, Vesa Halttunen wrote:
> On Mon, 2004-06-21 at 01:29, Marcel Holtmann wrote:
> > > > Do you enabled role switch and sniff mode support?
> > >
> > > No, I didn't. Should I, and if so, how?
> >
> > you really should, because I have seen that HID devices don't really
> > like if they can't switch into sniff mode. And if you don't enable role
> > switch your host can't become the master and so can't join your mouse
> > and keyboard into one piconet. Thus you get a scatternet and this can
> > cause troubles.
>
> I'm sorry but I don't know how. Could someone tell me?
>
> hcitool con shows the keyboard and the mouse as follows:
>
> Connections:
>         > ACL ..:..:..:..:..:.. handle 44 state 1 lm MASTER
>         > ACL ..:..:..:..:..:.. handle 41 state 1 lm MASTER
>
> I don't even know whether the device(s) are in the correct mode or not.
> I've been trying to gather bits and pieces of information together but
> so far no luck. I tried "hcitool cmd 0x02 0x0003" which, according to
> http://www.lisha.ufsc.br/~guto/teaching/ish/ine5346-2003-1/work/bluetooth/h
>ci_commands.html MIGHT put a device to "sniff mode" but at least nothing
> changed.
>
> Thanks,
>
> -Vesa


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
