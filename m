Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4041509E.9000402@superbug.demon.co.uk>
Date: Sun, 29 Feb 2004 02:38:22 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about correctness of hci_usb sco	support.
References: <403F8EAC.40701@superbug.demon.co.uk> <1077973622.2843.75.camel@pegasus>
In-Reply-To: <1077973622.2843.75.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>In hci_usb.c file, line 604 ish
>>static inline int __recv_frame(struct hci_usb *husb, int type, void 
>>*data, int count)
>>
>>Contains: -
>>case HCI_SCODATA_PKT:
>>        if (count >= HCI_SCO_HDR_SIZE) {
>>                  struct hci_sco_hdr *h = data;
>>                  len = HCI_SCO_HDR_SIZE + h->dlen;
>>        } else
>>                  return -EILSEQ;
>>        break;
>>
>>With a SCO HCI packet, it lasts 3 air frames for a bluetooth headset.
>>How do we know that the first frame we receive from the usb bluetooth 
>>device is the SCO HCI header?
> 
> 
> 	if (!skb) {
> 		/* Start of the frame */
> 
> 
>>What happens if the first SCO HCI frame we receive is actually the 
>>second or third frame in the SCO HCI packet ?
>>Surely some validation checks need to be done.
>>For example, depending on the sample format we are using, we should 
>>already know what the SCO HCI length should be, so we could check this 
>>against the length in the SCO HCI header, and only accept the frame if 
>>they match, if they don't match, drop the frame, and wait for the next 
>>frame.
>>I would expect similar problems with HCI int/bulk frames, but I don't 
>>actually see any corrupt int/bulk frames, so I was wondering whether the 
>>usb bluetooth dongle somehow ensures that the first air frame we receive 
>>is actually the start of an HCI frame. Maybe it is just luck, as 
>>int/bulk frames normally have a lot of blank invalid frames in between, 
>>so maybe as soon as it sees a valid frame, it is always the start of the 
>>int/bulk frame. I don't think we can make this assumtion all the time, 
>>in case we start filling the air entirely with bulk frames, and some air 
>>frames get lost. We will have to drop the hci frame, and then resync 
>>when the next hci frame arrives.
> 
> 
> I actually don't get your point, because the USB INT, BULK and ISOC
> URB's has nothing to do with the frames on the air. It is the HCI of the
> Bluetooth chip.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 

__recv_frame()  receives a frame from the USB interface.
It then joins up frames to create a full HCI packet to send to higher 
layers.
"struct sk_buff *skb = __reassembly(husb, type);"

So we have a skb for each HCI type.
The skb will not exist the first time we receive an frame of a 
particular type.
The current code always assumes that the first frame it receives of a 
particular type will always be the first frame of an HCI packet that 
might consist of multiple frames.
I can't understand how we can be 100% that the first frame seen is 
always the first frame of the HCI packet.
I can't see why we cannot ever see a situation where the first frame 
received of a particular type might instead be the second frame of the 
HCI packet. As the __recv_frame() uses the contents of that first frame 
to control the reassembly process. How can we be sure that that first 
frame does in fact contain the first frame of a valid HCI packet?
E.g. If a remote bluetooth device somehow creates an HCI packet with 
bogus HCI header, surely this could (worst case) crash the kernel?

E.g.

Frames coming from USB.
1) HCI header+data (Header contains details of how many frames are in 
this HCI packet via a packet length field, e.g 27 bytes, or 3 frames)
2) HCI data
3) HCI data

What happens if there is an error in the HCI header bytes, or frame (1) 
is somehow lost, so it then thinks frame (2) contains the HCI header+data ?

Summary: -
The current code works well if everything is very well behaved, but what 
happens if errors occur, or is there some mechanism to prevent any 
errors that I am not currently away of?

Cheers
James
