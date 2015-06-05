Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150605130004.GA13309@comms>
References: <CABBYNZK+AnuQM+EoLDaEwbr4hZnjxjfHy9gGM1bH1PEG-G7faQ@mail.gmail.com>
	<1432889606-3967-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20150601101141.GB31534@comms>
	<20150605130004.GA13309@comms>
Date: Fri, 5 Jun 2015 17:41:36 +0300
Message-ID: <CABBYNZ+tLBBzveCeSw=+o4LugNoB34_jKscJUiWR-fY9JGkPkg@mail.gmail.com>
Subject: Re: [PATCHv2] shared/att: Fix boolean check in handle_notify()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jun 5, 2015 at 4:00 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> ping
>
> On Mon, Jun 01, 2015 at 01:11:43PM +0300, Andrei Emeltchenko wrote:
>> ping
>>
>> On Fri, May 29, 2015 at 11:53:26AM +0300, Andrei Emeltchenko wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > ext_signed is boolean and shall be checked with logical op.
>> > ---
>> >  src/shared/att.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/src/shared/att.c b/src/shared/att.c
>> > index 053aa47..f9a5817 100644
>> > --- a/src/shared/att.c
>> > +++ b/src/shared/att.c
>> > @@ -733,7 +733,7 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>> >     const struct queue_entry *entry;
>> >     bool found;
>> >
>> > -   if (opcode & ATT_OP_SIGNED_MASK & !att->ext_signed) {
>> > +   if ((opcode & ATT_OP_SIGNED_MASK) && !att->ext_signed) {
>> >             if (!handle_signed(att, opcode, pdu, pdu_len))
>> >                     return;
>> >             pdu_len -= BT_ATT_SIGNATURE_LEN;
>> > --
>> > 2.1.4
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --

Applied, thanks.


-- 
Luiz Augusto von Dentz
