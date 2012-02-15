Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 15 Feb 2012 07:39:01 +0100
Subject: RE: [RFC]: AVRCP 1.4 Media API
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B20FDEC66EA@EXDCVYMBSTM005.EQ1STM.local>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B20FD87385C@EXDCVYMBSTM005.EQ1STM.local>
 <CABBYNZJveRUW-BkfX6H2B+06rHG=6ur1U=Z9vbGCQtOJNRm9FQ@mail.gmail.com>
 <747C1E83C744F44E9ACFB89FAEEC2C7B20FDEC66BA@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B20FDEC66BA@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Vani-dineshbhai PATEL X
> Sent: Thursday, February 02, 2012 3:40 PM
> To: 'Luiz Augusto von Dentz'
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: [RFC]: AVRCP 1.4 Media API
> 
> Hi,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> > Sent: Thursday, February 02, 2012 12:31 AM
> > To: Vani-dineshbhai PATEL X
> > Cc: linux-bluetooth@vger.kernel.org
> > Subject: Re: [RFC]: AVRCP 1.4 Media API
> >
> > Hi,
> >
> > On Tue, Jan 31, 2012 at 11:28 PM, Vani-dineshbhai PATEL X
> > <vani.patel@stericsson.com> wrote:
> > > Hi All,
> > >
> > > I have seen quite a few post in community about AVRCP 1.4 and there
> > were few discussion which have happened in past for this. I plan to
> > resume the work for developing following features of AVRCP 1.4
> > >
> > >            As per spec section 6.9.1     SetAddressedPlayer
> > >            As per spec section 6.9.2     Addressed Player Changed
> > Notification
> > >            As per spec section 6.9.3     SetBrowsedPlayer
> > >            As per spec section 6.9.4     Available Players Changed
> > Notification
> > >            As per spec section 6.10.3.3    UIDs Changed
> Notification
> > >            As per spec section 6.10.4.1    ChangePath
> > >            As per spec section 6.10.4.2    GetFolderItems
> > >            As per spec section 6.10.4.3    GetItemAttributes
> > >            As per spec section 6.12.1      PlayItem
> > >            As per spec section 6.13.1      Absolute Volume
> > >            As per spec section 6.13.3      Notify volume change
> > >
> >
> > IMO we should address this separately, first with absolute volume
> > control and then add media browsing.
> >
I agree with you. We shall break this down and address below things separately one by one - 
	1. Absolute Volume & Notify Volume Change
	2. SetAddressedPlayer and Addressed Player Changed
	3. Media Browsing

> > >
> > > From a8fbf052e5ad409d767fa54343ac8ce462ee80da Mon Sep 17 00:00:00
> > 2001
> > > From: Vani Patel <vani.patel@stericsson.com>
> > > Date: Tue, 24 Jan 2012 16:05:05 +0530
> > > Subject: [PATCH] AVRCP: Media API for AVRCP 1.4
> > >
> > > ---
> > > doc/media-api.txt |  321
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > 1 files changed, 316 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/doc/media-api.txt b/doc/media-api.txt index
> > c53ab7b..b6f557e 100644
> > > --- a/doc/media-api.txt
> > > +++ b/doc/media-api.txt
> > > @@ -2,7 +2,7 @@ BlueZ D-Bus Media API description
> > > *********************************
> > >
> > >  Media hierarchy
> > > -===============
> > > +=================================
> > >
> > >  Service          org.bluez
> > > Interface  org.bluez.Media
> > > @@ -85,6 +85,113 @@ Methods         void RegisterEndpoint(object
> > endpoint, dict properties)
> > >                       uint32 Position
> > >
> > >                              Playback position in milliseconds
> > > +
> > > +                       string Name
> > > +
> > > +                             Unique name of media player
> >
> > Probably not necessary since the sender + object path should give us a
> > unique name we can use to identify different players.
> 
> Yes, you are correct, This we can remove from here.
> 
> >
> > > +                       array{string} Type
> > > +
> > > +                             Possible values:
> > > +                                   "Audio",
> > > +                                   "Video",
> > > +                                   "Broadcast Audio",
> > > +                                   "Broadcast Video"
> > > +
> > > +                       array{string} SubType
> > > +
> > > +                             Possible values:
> > > +                                   "Audiobook",
> > > +                                   "Podcast"
> > > +
> > > +                       uint16 UidCounter
> > > +
> > > +                             Changes of this field signal changes
> in
> > media player
> > > +                             filesystem
> >
> > No idea why you need this, but I guess this is for media browsing so I
> > would have in separate.

Yes, you are correct, these are needed for Media browsing related commands.
"Type", "SubType" & "UidCounter" of the Media player are required to be sent to CT in response to "GetFolderItems" for Media Player List scope. 
Getting this information during registration of media player shall avoid a separate D-bus call when CT requests GetFolderItems command for Media Player List scope. 
Is this approach of fetching as much information about the player during registration and saving in our database (Media.c) correct? 
I am trying to minimize D-Bus calls as much possible. Please guide me if my approach is correct or not. 

As suggested by you, we shall address these parameters in separate while addressing Media Browsing related APIs.  

> >
> UIDCounter is required firstly to know whether the player is Database
> aware/unaware. Also, This shall be used while setting Addressed player.
> So While we register the media player, media player shall send its UID
> counter and if that is later changed, it can be managed by
> AddressedPlayerChanged notification. This avoids one dbus call while
> setting a new addressed player (setAddressedPlayer)
> 
> > > +                       array{string} Features
> > > +
> > > +                             Possible values:
> > > +                                   "PASSTHROUGH Select",
> > > +                                   "PASSTHROUGH Up",
> > > +                                   "PASSTHROUGH Down",
> > > +                                   "PASSTHROUGH Left",
> > > +                                   "PASSTHROUGH Right",
> > > +                                   "PASSTHROUGH Right-Up",
> > > +                                   "PASSTHROUGH Right-Down",
> > > +                                   "PASSTHROUGH Left-Up",
> > > +                                   "PASSTHROUGH Left-Down",
> > > +                                   "PASSTHROUGH Root Menu",
> > > +                                   "PASSTHROUGH Setup Menu",
> > > +                                   "PASSTHROUGH Contents Menu",
> > > +                                   "PASSTHROUGH Favourite Manu",
> > > +                                   "PASSTHROUGH Exit",
> > > +                                   "PASSTHROUGH 0",
> > > +                                   "PASSTHROUGH 1",
> > > +                                   "PASSTHROUGH 2",
> > > +                                   "PASSTHROUGH 3",
> > > +                                   "PASSTHROUGH 4",
> > > +                                   "PASSTHROUGH 5",
> > > +                                   "PASSTHROUGH 6",
> > > +                                   "PASSTHROUGH 7",
> > > +                                   "PASSTHROUGH 8",
> > > +                                   "PASSTHROUGH 9",
> > > +                                   "PASSTHROUGH Dot",
> > > +                                   "PASSTHROUGH Enter",
> > > +                                   "PASSTHROUGH Clear",
> > > +                                   "PASSTHROUGH Channel Up",
> > > +                                   "PASSTHROUGH Channel Down",
> > > +                                   "PASSTHROUGH Previous Channel",
> > > +                                   "PASSTHROUGH Sound Select",
> > > +                                   "PASSTHROUGH Input Select",
> > > +                                   "PASSTHROUGH Display
> > Information",
> > > +                                   "PASSTHROUGH Help",
> > > +                                   "PASSTHROUGH Page Up",
> > > +                                   "PASSTHROUGH Page Down",
> > > +                                   "PASSTHROUGH Power",
> > > +                                   "PASSTHROUGH Volume Up",
> > > +                                   "PASSTHROUGH Volume Down",
> > > +                                   "PASSTHROUGH Mute",
> > > +                                   "PASSTHROUGH Play",
> > > +                                   "PASSTHROUGH Stop",
> > > +                                   "PASSTHROUGH Pause",
> > > +                                   "PASSTHROUGH Record",
> > > +                                   "PASSTHROUGH Rewind",
> > > +                                   "PASSTHROUGH Fast Forward",
> > > +                                   "PASSTHROUGH Eject",
> > > +                                   "PASSTHROUGH Forward",
> > > +                                   "PASSTHROUGH Backward",
> > > +                                   "PASSTHROUGH Angle",
> > > +                                   "PASSTHROUGH SubPicture",
> > > +                                   "PASSTHROUGH F1",
> > > +                                   "PASSTHROUGH F2",
> > > +                                   "PASSTHROUGH F3",
> > > +                                   "PASSTHROUGH F4",
> > > +                                   "PASSTHROUGH F4",
> > > +                                   "PASSTHROUGH F5",
> > > +                                   "Vendor Unique",
> > > +                                   "Basic Group Navigation",
> > > +                                   "Advanced Control Player",
> > > +                                   "Browsing",
> > > +                                   "Searching",
> > > +                                   "AddToNowPlaying",
> > > +                                   "UID Unique",
> > > +                                   "Only Browseable When
> Addresed",
> > > +                                   "Only Searchable When
> Addresed",
> > > +                                   "NowPlaying",
> > > +                                   "UID Persistancy"
> >
> > This is way too big, I guess we can group the passthrough in a single
> > one since if the player doesn't support some it can just ignore, 
As suggested by you, we have changed "array{string} Features" to "uint16 Features" and shall make one bit mask for passthrough features supported rather than making an array.
> > also for browsing we might have a different interface since the database
> > may not be directly handled by the player. Actually I strong believe
Can you please let me know where I can get more information about this browsing interface? This shall help us more while fixing APIs for Media browsing related commands.

> > browsing would fit better as an OBEX based profile because of the
> > operations and the relation with a database is very similar to other
> > OBEX based profiles such as PBAP and MAP, but I guess it is too late
> > to do something about it.
> 
Yes, This is very true. OBEX based profile is actually more suitable to re-use here rather than implementing a whole new browsing operation in AVRCP. 
> 
> We plan to change the type of features to Uint16 and plan to set the
> features bitwise through media player.
> Hence it shall be "uint16 Features" instead of "array{string} Features"
> 
> >
> > > +                       byte Volume
> > > +
> > > +                             Current Volume in percent range: 0 -
> > 100
> >
> > Im afraid Volume belong to MediaTransport not to MediaPlayer,
> > otherwise we are just able to change the volume of the addressed
> > player not the master volume of the headset itself which the playback
> > can be mixed with different audio source.
> 

Yes, I agree, you are correct. I shall move Volume to MediaTransport interface.

> Here Volume belongs to "org.bluez.Media" and not
> "org.bluez.MediaPlayer".
> Let me know if this is correct.
> 
> >
> > --
> > Luiz Augusto von Dentz
> 
> Vani

Vani
