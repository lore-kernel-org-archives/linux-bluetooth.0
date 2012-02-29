Return-Path: <cyrus@holtmann.org>
From: "Kumar, Sunil A" <sunil.a.kumar@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>,
	"Khanzode, Prashant" <prashant.khanzode@intel.com>,
	"Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: Response to AVRCP Passthrough Commands.
Date: Wed, 29 Feb 2012 12:20:47 +0000
Message-ID: <8948CE8A2D1716449B389D5F68D4A30E02072B@FMSMSX108.amr.corp.intel.com>
References: <8948CE8A2D1716449B389D5F68D4A30E02048F@FMSMSX108.amr.corp.intel.com>
	<20120228130505.GA4170@vader>
 <CABBYNZL32nUYXTXTM1gCmRhGms5qGpW2uibyT5j5gDBow8Akiw@mail.gmail.com>
In-Reply-To: <CABBYNZL32nUYXTXTM1gCmRhGms5qGpW2uibyT5j5gDBow8Akiw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz/Lucas,

Thanks for your inputs.

I agree that situation can be workaround to a great extent using metadata in devices supporting the same. Though, the error codes hold importance in some cases:

- Purely from specification perspective, we are not doing right thing here. But, we can ignore this until we have strong reasons for not doing so :-)
- Consider a Carkit which supports Media Player with TOUCH BUTTONS and still operating with AVRCP 1.0. User presses the Play button to start the music playback but TG could not really start it because of an internal error. In this case, if TG responds with ACCEPTED then I expect Carkit to change Play button to Pause button even though playback has not started (many of the Carkits really will not look at A2DP state to change the play button to pause button) whereas if TG responds with REJECTED then Play button will still stay as Play which is right as well so that user can try again.
- Assumption in Bluez that application supports all commands supported by Bluez is not right as some of these commands are optional and hence, application can choose to not support. And hence, it might be better option to leave the final decision on user (application in this case) but of course, we have complexities in place mentioned by Luiz.

Again, as Luiz said effort is really high to change the design. So, not sure if gains are really proportional and hence, please see if we really need to do something here.

Lucas,

Thanks for the patch. I was not able to test it today but will test it tomorrow and send you the feedback.
Thanks.

Best Regards 
Sunil Kumar
-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com] 
Sent: Tuesday, February 28, 2012 7:22 PM
To: Lucas De Marchi
Cc: Kumar, Sunil A; linux-bluetooth@vger.kernel.org; Nair, Rashmi G; Khanzode, Prashant; Von Dentz, Luiz
Subject: Re: Response to AVRCP Passthrough Commands.

Hi Lucas,

On Tue, Feb 28, 2012 at 3:05 PM, Lucas De Marchi <lucas.demarchi@profusion.mobi> wrote:
> Hi Kumar,
>
> * Kumar, Sunil A <sunil.a.kumar@intel.com> [2012-02-28 09:47:20 +0000]:
>
>> Hi,
>>
>> The passthrough command handler - handle_panel_passthrough - ends up responding with response code - ACCEPTED - in below mentioned cases whereas expected response code as per specification is different. Please find the cases and expected response code mentioned below. The document referred for specifying the expected response code is " AV/C Digital Interface Command Set General Specification Version 4.2" which is referred to in AVRCP specification.
>>
>> 1- Command is supported by Bluez but the Media App doesn't support the same e.g. "FAST FORWARD" is supported by Bluez means present in " key_map" table but Android Froyo Media App doesn't support the same.
>>       - As per point 5 of section "6.3 AV/C response rules" in above specified document, the expected response code is - NOT IMPLEMENTED. Here is the text for point 5 from document: " If the fields marked in the ck column of the command frame include the unsupported value, the target shall return a NOT IMPLEMENTED response."
>
> As per current implementation, the application on top of BlueZ is 
> supposed to implement that commands.

We could in theory have the supported_keys as property when registering the MediaPlayer, the problem is that we don't know what Player or application will be in focus to receive the keys.

Btw what would you do if you with not implemented? Make FAST FORWARD unavailable? Bear in mind that you can have multiple players in the system, so the 1:1 map that AV/C and AVRCP uses is not really what BlueZ is target, in other words it is not a TV or microsystem with single mode to work, also note that normally in such case the target is that one that display the error since the controller is just a input device which is exactly how we are treating it by using uinput.

>
>>
>> 2- Command is supported by Bluez and the Media App. But, command can't be executed at this time because of an error e.g. "PLAY" is supported by Bluez and Media App but playback is not possible when Media App receives this command because of an error.
>>       - As per point 6 of section "6.3 AV/C response rules" in above specified document, the expected response code is - REJECTED. Here is the text for point 6 from document: " If the target can not execute the CONTROL, STATUS, or NOTIFY command, and a NOT IMPLEMENTED response would not be required for the command, the target shall return a REJECTED response."

Again what would you do with rejected? Does it make any difference if we cannot say what the error is about or display it to the user.

>> 3- Command is not supported by Bluez itself, so doesn't matter whether Media App supports it or not. e.g. " key_map" table is modified to remove "FAST FORWARD".
>>       - As per point 5 of section "6.3 AV/C response rules" in above specified document, the expected response code is - NOT IMPLEMENTED. Here is the text for point 5 from document: " If the fields marked in the ck column of the command frame include the unsupported value, the target shall return a NOT IMPLEMENTED response."
>
> In this latter case it seems a bug indeed. Does the patch bellow fix 
> the issue for you?

Yep that is fine because we know that we will never implement it regardless of what application is running because we could not translate the command to a key press, although Im afraid this makes no difference to the controller.

>>
>> Could someone help answering following queries:
>>       - What is the reason for Bluez to respond with response code - ACCEPTED - in these cases? Is this well thought of or just an issue?
>
> The last one is probably a bug. Could you test the patch and see if it 
> passes all related tests in PTS?
>
>>       - If this is not an issue, it shall be great help if you can provide the reasons for current implementation.
>
> We use uinput here to send the commands. uinput is just like a 
> keyboard pressing that "media keys". The problem here is that there's 
> no feedback from the application if the command was accepted or not.
>
> Luiz, what do you think?

With uinput we have no feedback no, and if we need one than we have to direct target a single application and it will no longer use a traditional input method to handle those events, so chances are that this will need a lot of effort for basically nothing since the controllers normally cannot anything about it, they are Panel with buttons. The ones with metadata support fix this because then you have a real feedback of the playback, so you know when PLAY failed because the metadata reflect that, same thing with FAST FORWARD not being supported the position will not go forward.

>
>>       - If this is an issue, is there already a plan to correct it? We need to establish the mechanism wherein Bluez waits for response from client (Media App) whenever necessary (case 1 and 2 mentioned above) before sending response.
>
> Unless we stop using uinput to use another mechanism to send the 
> commands to application, I don't see an easy way to fix it.

Use the metadata.

>
> Regards,
> Lucas De Marchi
>
> ---
> Subject: AVCTP: return not-implemented for unknown passthrough command
>
> diff --git a/audio/avctp.c b/audio/avctp.c index 5bd5db1..e36353d 
> 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -235,9 +235,12 @@ static size_t handle_panel_passthrough(struct 
> avctp *session,
>                break;
>        }
>
> -       if (key_map[i].name == NULL)
> +       if (key_map[i].name == NULL) {
>                DBG("AV/C: unknown button 0x%02X %s",
>                                                operands[0] & 0x7F, 
> status);
> +               *code = AVC_CTYPE_NOT_IMPLEMENTED;
> +               return 0;
> +       }
>
>  done:
>        *code = AVC_CTYPE_ACCEPTED;

Patch looks good, can you send a proper one to be applied?

--
Luiz Augusto von Dentz
