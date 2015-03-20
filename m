Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <DFF116A1-231A-4DBE-A760-791B7A5930B0@holtmann.org>
References: <1426869750-26707-1-git-send-email-jpawlowski@google.com>
	<DFF116A1-231A-4DBE-A760-791B7A5930B0@holtmann.org>
Date: Fri, 20 Mar 2015 10:57:14 -0700
Message-ID: <CAD0=r8wgNFiZgqR4+CHJ7ZC43D7E-3Whs+Gg8cCkpB5fcoQ4pA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: expose quirks through debugfs
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 20, 2015 at 10:09 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jakub,
>
> > This patch adds macro for exposing quirks through debugfs. Exposing
> > quirks would be useful for making quirk dependent BlueZ tests using
> > vhci. Currently there is no way to test that. It might be also
> > useful for manual testing.
> >
> > This patch also uses this macro to expose first two quirks.
> >
> > Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> > ---
> > net/bluetooth/hci_debugfs.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 59 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> > index 0818fab..a45a0c8 100644
> > --- a/net/bluetooth/hci_debugfs.c
> > +++ b/net/bluetooth/hci_debugfs.c
> > @@ -28,6 +28,54 @@
> >
> > #include "hci_debugfs.h"
>
> this looks good to me, but I think we need to make some cosmetic changes to have it fit cleaner with how other parts of the kernel do these helper macros.
>
> > +#define DEFINE_QUIRK_ATTRIBUTE(ATTRIBUTE_NAME, QUIRK_NAME)                 \
>
> Lets name these _name and _quirk instead. I did not find a good reference where they have been used in uppercase.
I've looked at DEFINE_SIMPLE_ATTRIBUTE and decided to use "__" instead
of single _
>
> > +static ssize_t ATTRIBUTE_NAME##_read(struct file *file,                            \
> > +                             char __user *user_buf,                        \
> > +                             size_t count, loff_t *ppos)                   \
>
> You might want to do _name ## _read with the proper spaces in between. That seems to be a bit more common.
>
> > +{                                                                          \
> > +     struct hci_dev *hdev = file->private_data;                            \
> > +     char buf[3];                                                          \
> > +                                                                           \
> > +     buf[0] = test_bit(QUIRK_NAME, &hdev->quirks) ? 'Y' : 'N';             \
> > +     buf[1] = '\n';                                                        \
> > +     buf[2] = '\0';                                                        \
> > +     return simple_read_from_buffer(user_buf, count, ppos, buf, 2);        \
> > +}                                                                          \
> > +                                                                           \
> > +static ssize_t ATTRIBUTE_NAME##_write(struct file *file,                   \
> > +                              const char __user *user_buf,                 \
> > +                              size_t count, loff_t *ppos)                  \
> > +{                                                                          \
> > +     struct hci_dev *hdev = file->private_data;                            \
> > +     char buf[32];                                                         \
> > +     size_t buf_size = min(count, (sizeof(buf) - 1));                      \
> > +     bool enable;                                                          \
> > +                                                                           \
> > +     if (test_bit(HCI_UP, &hdev->flags))                                   \
> > +             return -EBUSY;                                                \
> > +                                                                           \
> > +     if (copy_from_user(buf, user_buf, buf_size))                          \
> > +             return -EFAULT;                                               \
> > +                                                                           \
> > +     buf[buf_size] = '\0';                                                 \
> > +     if (strtobool(buf, &enable))                                          \
> > +             return -EINVAL;                                               \
> > +                                                                           \
> > +     if (enable == test_bit(QUIRK_NAME, &hdev->quirks))                    \
> > +             return -EALREADY;                                             \
> > +                                                                           \
> > +     change_bit(QUIRK_NAME, &hdev->quirks);                                \
> > +                                                                           \
> > +     return count;                                                         \
> > +}                                                                          \
> > +                                                                           \
> > +static const struct file_operations ATTRIBUTE_NAME##_fops = {                      \
> > +     .open           = simple_open,                                        \
> > +     .read           = ATTRIBUTE_NAME##_read,                              \
> > +     .write          = ATTRIBUTE_NAME##_write,                             \
>
> And I would do the same here, _name ## _read.
>
> > +     .llseek         = default_llseek,                                     \
> > +}                                                                          \
> > +
> > static int features_show(struct seq_file *f, void *ptr)
> > {
> >       struct hci_dev *hdev = f->private;
> > @@ -277,6 +325,11 @@ static const struct file_operations sc_only_mode_fops = {
> >       .llseek         = default_llseek,
> > };
> >
> > +DEFINE_QUIRK_ATTRIBUTE(quirk_strict_duplicate_filter,
> > +                    HCI_QUIRK_STRICT_DUPLICATE_FILTER);
> > +DEFINE_QUIRK_ATTRIBUTE(quirk_simulteanous_discovery,
> > +                    HCI_QUIRK_SIMULTANEOUS_DISCOVERY);
> > +
> > void hci_debugfs_create_common(struct hci_dev *hdev)
> > {
> >       debugfs_create_file("features", 0444, hdev->debugfs, hdev,
> > @@ -308,6 +361,12 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
> >       if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
> >               debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
> >                                   hdev, &sc_only_mode_fops);
> > +     debugfs_create_file("quirk_strict_duplicate_filter", 0644,
> > +                         hdev->debugfs, hdev,
> > +                         &quirk_strict_duplicate_filter_fops);
> > +     debugfs_create_file("quirk_simulteanous_discovery", 0644,
> > +                         hdev->debugfs, hdev,
> > +                         &quirk_simulteanous_discovery_fops);
>
> If you want to, you could create a second macro for these.
>
>         debugfs_create_quirk(hdev, strict_duplicate_filter);
>
> All the string magic etc. can be done by a define. Could be also your second patch to make this even simple and we the first one in first after the cosmetic cleanup.

I'll look into that.
Thanks for quick review!

>
> Regards
>
> Marcel
>
