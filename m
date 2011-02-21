Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 21 Feb 2011 18:09:06 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Ott <alan@signal11.us>, Antonio Ospite <ospite@studenti.unina.it>,
	linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Bastien Nocera <hadess@hadess.net>, Jim Paris <jim@jtan.com>,
	"pascal@pabr.org" <pascal@pabr.org>
Subject: Re: [PATCH 2/2] bt hidp: send Output reports using SET_REPORT on the
 Control channel
Message-ID: <20110221210906.GI2965@joana>
References: <alpine.LNX.2.00.1102180944590.2160@pobox.suse.cz>
 <1298222806-19433-1-git-send-email-ospite@studenti.unina.it>
 <1298222806-19433-3-git-send-email-ospite@studenti.unina.it>
 <4D61DFE0.5020400@signal11.us>
 <alpine.LNX.2.00.1102211349550.2160@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1102211349550.2160@pobox.suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

* Jiri Kosina <jkosina@suse.cz> [2011-02-21 13:50:40 +0100]:

> On Sun, 20 Feb 2011, Alan Ott wrote:
> 
> > On 02/20/2011 12:26 PM, Antonio Ospite wrote:
> > > The current implementation of hidp_output_raw_report() relies only on
> > > the Control channel even for Output reports, and the BT HID
> > > specification [1] does not mention using the DATA message for Output
> > > reports on the Control channel (see section 7.9.1 and also Figure 11:
> > > SET_ Flow Chart), so let us just use SET_REPORT.
> > > 
> > > This also fixes sending Output reports to some devices (like Sony
> > > Sixaxis) which are not able to handle DATA messages on the Control
> > > channel.
> > > 
> > > Ideally hidp_output_raw_report() could be improved to use this scheme:
> > >    Feature Report -- SET_REPORT on the Control channel
> > >    Output Report  -- DATA on the Interrupt channel
> > > for more efficiency, but as said above, right now only the Control
> > > channel is used.
> > > 
> > > [1] http://www.bluetooth.com/Specification%20Documents/HID_SPEC_V10.pdf
> > > 
> > >   	case HID_OUTPUT_REPORT:
> > > -		report_type = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
> > > +		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
> > >    
> > 
> > I think this is right. Section 7.4[.0] says that SET_ and GET_ requests return
> > with HANDSHAKE. Section 7.4.9 says that DATA does _not_ return a HANDSHAKE. My
> > patch to hidp_output_raw_report() relies on getting a HANDSHAKE back, so it
> > wouldn't have worked with BT devices that take output reports. Since I don't
> > have any that do, I couldn't test it. (And it was like that when I got here :)
> > )
> > 
> > For the whole set:
> > Acked-by: Alan Ott <alan@signal11.us>
> 
> Agreed.
> 
> As an author of the original code, I agree with the change. But as it is 
> in net/bluetooth, I'd at least have Acked-by from some of the Bluetooth 
> folks before I take it through my tree.
> 
> Marcel? Gustavo?

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
http://profusion.mobi
