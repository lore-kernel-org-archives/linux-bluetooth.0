Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180703080427.25791-1-luiz.dentz@gmail.com>
References: <20180703080427.25791-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Jul 2018 20:05:03 +0300
Message-ID: <CABBYNZLQPJqB16p2m0gpV8N4ASjYcDM3u4ZWc7PAfwJTddrFCQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Consolidate code printing bitfield
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 3, 2018 at 11:04 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This reduces the duplicated code around printing bitfields.
> ---
>  monitor/display.h |  22 +++
>  monitor/l2cap.c   |  32 +---
>  monitor/packet.c  | 381 ++++++++--------------------------------------
>  3 files changed, 92 insertions(+), 343 deletions(-)
>
> diff --git a/monitor/display.h b/monitor/display.h
> index b85f37b9a..12d13f873 100644
> --- a/monitor/display.h
> +++ b/monitor/display.h
> @@ -23,6 +23,7 @@
>   */
>
>  #include <stdbool.h>
> +#include <inttypes.h>
>
>  bool use_color(void);
>
> @@ -64,6 +65,27 @@ do { \
>  #define print_field(fmt, args...) \
>                 print_indent(8, COLOR_OFF, "", "", COLOR_OFF, fmt, ## args)
>
> +struct bitfield_data {
> +       uint64_t bit;
> +       const char *str;
> +};
> +
> +inline uint64_t print_bitfield(int indent, uint64_t val,
> +                               const struct bitfield_data *table)
> +{
> +       uint64_t mask = val;
> +       int i;
> +
> +       for (i = 0; table[i].str; i++) {
> +               if (val & (((uint64_t) 1) << table[i].bit)) {
> +                       print_field("%*c%s", indent, ' ', table[i].str);
> +                       mask &= ~(((uint64_t) 1) << table[i].bit);
> +               }
> +       }
> +
> +       return mask;
> +}
> +
>  int num_columns(void);
>
>  void open_pager(void);
> diff --git a/monitor/l2cap.c b/monitor/l2cap.c
> index c85934af1..ef2a14410 100644
> --- a/monitor/l2cap.c
> +++ b/monitor/l2cap.c
> @@ -916,10 +916,7 @@ static void print_info_result(uint16_t result)
>         print_field("Result: %s (0x%4.4x)", str, le16_to_cpu(result));
>  }
>
> -static struct {
> -       uint8_t bit;
> -       const char *str;
> -} features_table[] = {
> +static const struct bitfield_data features_table[] = {
>         {  0, "Flow control mode"                       },
>         {  1, "Retransmission mode"                     },
>         {  2, "Bi-directional QoS"                      },
> @@ -936,26 +933,16 @@ static struct {
>
>  static void print_features(uint32_t features)
>  {
> -       uint32_t mask = features;
> -       int i;
> +       uint32_t mask;
>
>         print_field("Features: 0x%8.8x", features);
>
> -       for (i = 0; features_table[i].str; i++) {
> -               if (features & (1 << features_table[i].bit)) {
> -                       print_field("  %s", features_table[i].str);
> -                       mask &= ~(1 << features_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, features, features_table);
>         if (mask)
>                 print_field("  Unknown features (0x%8.8x)", mask);
>  }
>
> -static struct {
> -       uint16_t cid;
> -       const char *str;
> -} channels_table[] = {
> +static const struct bitfield_data channels_table[] = {
>         { 0x0000, "Null identifier"             },
>         { 0x0001, "L2CAP Signaling (BR/EDR)"    },
>         { 0x0002, "Connectionless reception"    },
> @@ -970,18 +957,11 @@ static struct {
>
>  static void print_channels(uint64_t channels)
>  {
> -       uint64_t mask = channels;
> -       int i;
> +       uint64_t mask;
>
>         print_field("Channels: 0x%16.16" PRIx64, channels);
>
> -       for (i = 0; channels_table[i].str; i++) {
> -               if (channels & (1 << channels_table[i].cid)) {
> -                       print_field("  %s", channels_table[i].str);
> -                       mask &= ~(1 << channels_table[i].cid);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, channels, channels_table);
>         if (mask)
>                 print_field("  Unknown channels (0x%8.8" PRIx64 ")", mask);
>  }
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 6798373bc..d69d6a020 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -750,10 +750,7 @@ static void print_phy_handle(uint8_t phy_handle)
>         print_field("Physical handle: %d", phy_handle);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} pkt_type_table[] = {
> +static const struct bitfield_data pkt_type_table[] = {
>         {  1, "2-DH1 may not be used"   },
>         {  2, "3-DH1 may not be used"   },
>         {  3, "DM1 may be used"         },
> @@ -771,29 +768,17 @@ static const struct {
>
>  static void print_pkt_type(uint16_t pkt_type)
>  {
> -       uint16_t mask;
> -       int i;
> -
> -       print_field("Packet type: 0x%4.4x", le16_to_cpu(pkt_type));
> +       uint16_t mask = le16_to_cpu(pkt_type);
>
> -       mask = le16_to_cpu(pkt_type);
> -
> -       for (i = 0; pkt_type_table[i].str; i++) {
> -               if (le16_to_cpu(pkt_type) & (1 << pkt_type_table[i].bit)) {
> -                       print_field("  %s", pkt_type_table[i].str);
> -                       mask &= ~(1 << pkt_type_table[i].bit);
> -               }
> -       }
> +       print_field("Packet type: 0x%4.4x", mask);
>
> +       mask = print_bitfield(2, mask, pkt_type_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_PKT_TYPE_BIT,
>                                 "  Unknown packet types (0x%4.4x)", mask);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} pkt_type_sco_table[] = {
> +static const struct bitfield_data pkt_type_sco_table[] = {
>         {  0, "HV1 may be used"         },
>         {  1, "HV2 may be used"         },
>         {  2, "HV3 may be used"         },
> @@ -809,20 +794,11 @@ static const struct {
>
>  static void print_pkt_type_sco(uint16_t pkt_type)
>  {
> -       uint16_t mask;
> -       int i;
> -
> -       print_field("Packet type: 0x%4.4x", le16_to_cpu(pkt_type));
> +       uint16_t mask = le16_to_cpu(pkt_type);
>
> -       mask = le16_to_cpu(pkt_type);
> -
> -       for (i = 0; pkt_type_sco_table[i].str; i++) {
> -               if (le16_to_cpu(pkt_type) & (1 << pkt_type_sco_table[i].bit)) {
> -                       print_field("  %s", pkt_type_sco_table[i].str);
> -                       mask &= ~(1 << pkt_type_sco_table[i].bit);
> -               }
> -       }
> +       print_field("Packet type: 0x%4.4x", mask);
>
> +       mask = print_bitfield(2, mask, pkt_type_sco_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_PKT_TYPE_BIT,
>                                 "  Unknown packet types (0x%4.4x)", mask);
> @@ -885,10 +861,7 @@ static void print_encrypt_mode(uint8_t mode)
>         print_field("Mode: %s (0x%2.2x)", str, mode);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} svc_class_table[] = {
> +static const struct bitfield_data svc_class_table[] = {
>         { 0, "Positioning (Location identification)"            },
>         { 1, "Networking (LAN, Ad hoc)"                         },
>         { 2, "Rendering (Printing, Speaker)"                    },
> @@ -1084,15 +1057,7 @@ static void print_dev_class(const uint8_t *dev_class)
>                 return;
>         }
>
> -       mask = dev_class[2];
> -
> -       for (i = 0; svc_class_table[i].str; i++) {
> -               if (dev_class[2] & (1 << svc_class_table[i].bit)) {
> -                       print_field("  %s", svc_class_table[i].str);
> -                       mask &= ~(1 << svc_class_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, dev_class[2], svc_class_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_SERVICE_CLASS,
>                                 "  Unknown service class (0x%2.2x)", mask);
> @@ -2536,12 +2501,7 @@ static void print_commands(const uint8_t *commands)
>         }
>  }
>
> -struct features_data {
> -       uint8_t bit;
> -       const char *str;
> -};
> -
> -static const struct features_data features_page0[] = {
> +static const struct bitfield_data features_page0[] = {
>         {  0, "3 slot packets"                          },
>         {  1, "5 slot packets"                          },
>         {  2, "Encryption"                              },
> @@ -2601,7 +2561,7 @@ static const struct features_data features_page0[] = {
>         { }
>  };
>
> -static const struct features_data features_page1[] = {
> +static const struct bitfield_data features_page1[] = {
>         {  0, "Secure Simple Pairing (Host Support)"    },
>         {  1, "LE Supported (Host)"                     },
>         {  2, "Simultaneous LE and BR/EDR (Host)"       },
> @@ -2609,7 +2569,7 @@ static const struct features_data features_page1[] = {
>         { }
>  };
>
> -static const struct features_data features_page2[] = {
> +static const struct bitfield_data features_page2[] = {
>         {  0, "Connectionless Slave Broadcast - Master" },
>         {  1, "Connectionless Slave Broadcast - Slave"  },
>         {  2, "Synchronization Train"                   },
> @@ -2624,7 +2584,7 @@ static const struct features_data features_page2[] = {
>         { }
>  };
>
> -static const struct features_data features_le[] = {
> +static const struct bitfield_data features_le[] = {
>         {  0, "LE Encryption"                           },
>         {  1, "Connection Parameter Request Procedure"  },
>         {  2, "Extended Reject Indication"              },
> @@ -2648,7 +2608,7 @@ static const struct features_data features_le[] = {
>  static void print_features(uint8_t page, const uint8_t *features_array,
>                                                                 uint8_t type)
>  {
> -       const struct features_data *features_table = NULL;
> +       const struct bitfield_data *features_table = NULL;
>         uint64_t mask, features = 0;
>         char str[41];
>         int i;
> @@ -2686,15 +2646,7 @@ static void print_features(uint8_t page, const uint8_t *features_array,
>         if (!features_table)
>                 return;
>
> -       mask = features;
> -
> -       for (i = 0; features_table[i].str; i++) {
> -               if (features & (((uint64_t) 1) << features_table[i].bit)) {
> -                       print_field("  %s", features_table[i].str);
> -                       mask &= ~(((uint64_t) 1) << features_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, features, features_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown features "
>                                                 "(0x%16.16" PRIx64 ")", mask);
> @@ -2724,10 +2676,7 @@ void packet_print_features_ll(const uint8_t *features)
>  #define LE_STATE_SLAVE_SLAVE           0x0800
>  #define LE_STATE_MASTER_SLAVE          0x1000
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} le_states_desc_table[] = {
> +static const struct bitfield_data le_states_desc_table[] = {
>         {  0, "Scannable Advertising State"                     },
>         {  1, "Connectable Advertising State"                   },
>         {  2, "Non-connectable Advertising State"               },
> @@ -2890,10 +2839,7 @@ static void print_encrypted_diversifier(uint16_t ediv)
>         print_field("Encrypted diversifier: 0x%4.4x", le16_to_cpu(ediv));
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} events_table[] = {
> +static const struct bitfield_data events_table[] = {
>         {  0, "Inquiry Complete"                                        },
>         {  1, "Inquiry Result"                                          },
>         {  2, "Connection Complete"                                     },
> @@ -2949,7 +2895,8 @@ static const struct {
>         { }
>  };
>
> -static void print_event_mask(const uint8_t *events_array)
> +static void print_event_mask(const uint8_t *events_array,
> +                                       const struct bitfield_data *table)
>  {
>         uint64_t mask, events = 0;
>         int i;
> @@ -2959,24 +2906,13 @@ static void print_event_mask(const uint8_t *events_array)
>
>         print_field("Mask: 0x%16.16" PRIx64, events);
>
> -       mask = events;
> -
> -       for (i = 0; events_table[i].str; i++) {
> -               if (events & (((uint64_t) 1) << events_table[i].bit)) {
> -                       print_field("  %s", events_table[i].str);
> -                       mask &= ~(((uint64_t) 1) << events_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, events, table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_EVENT_MASK, "  Unknown mask "
>                                                 "(0x%16.16" PRIx64 ")", mask);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} events_page2_table[] = {
> +static const struct bitfield_data events_page2_table[] = {
>         {  0, "Physical Link Complete"                                  },
>         {  1, "Channel Selected"                                        },
>         {  2, "Disconnection Physical Link Complete"                    },
> @@ -3005,34 +2941,7 @@ static const struct {
>         { }
>  };
>
> -static void print_event_mask_page2(const uint8_t *events_array)
> -{
> -       uint64_t mask, events = 0;
> -       int i;
> -
> -       for (i = 0; i < 8; i++)
> -               events |= ((uint64_t) events_array[i]) << (i * 8);
> -
> -       print_field("Mask: 0x%16.16" PRIx64, events);
> -
> -       mask = events;
> -
> -       for (i = 0; events_page2_table[i].str; i++) {
> -               if (events & (((uint64_t) 1) << events_page2_table[i].bit)) {
> -                       print_field("  %s", events_page2_table[i].str);
> -                       mask &= ~(((uint64_t) 1) << events_page2_table[i].bit);
> -               }
> -       }
> -
> -       if (mask)
> -               print_text(COLOR_UNKNOWN_EVENT_MASK, "  Unknown mask "
> -                                               "(0x%16.16" PRIx64 ")", mask);
> -}
> -
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} events_le_table[] = {
> +static const struct bitfield_data events_le_table[] = {
>         {  0, "LE Connection Complete"                  },
>         {  1, "LE Advertising Report"                   },
>         {  2, "LE Connection Update Complete"           },
> @@ -3056,30 +2965,6 @@ static const struct {
>         { }
>  };
>
> -static void print_event_mask_le(const uint8_t *events_array)
> -{
> -       uint64_t mask, events = 0;
> -       int i;
> -
> -       for (i = 0; i < 8; i++)
> -               events |= ((uint64_t) events_array[i]) << (i * 8);
> -
> -       print_field("Mask: 0x%16.16" PRIx64, events);
> -
> -       mask = events;
> -
> -       for (i = 0; events_le_table[i].str; i++) {
> -               if (events & (((uint64_t) 1) << events_le_table[i].bit)) {
> -                       print_field("  %s", events_le_table[i].str);
> -                       mask &= ~(((uint64_t) 1) << events_le_table[i].bit);
> -               }
> -       }
> -
> -       if (mask)
> -               print_text(COLOR_UNKNOWN_EVENT_MASK, "  Unknown mask "
> -                                               "(0x%16.16" PRIx64 ")", mask);
> -}
> -
>  static void print_fec(uint8_t fec)
>  {
>         const char *str;
> @@ -3354,10 +3239,7 @@ static void print_uuid128_list(const char *label, const void *data,
>         }
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} eir_flags_table[] = {
> +static const struct bitfield_data eir_flags_table[] = {
>         { 0, "LE Limited Discoverable Mode"             },
>         { 1, "LE General Discoverable Mode"             },
>         { 2, "BR/EDR Not Supported"                     },
> @@ -3366,10 +3248,7 @@ static const struct {
>         { }
>  };
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} eir_3d_table[] = {
> +static const struct bitfield_data eir_3d_table[] = {
>         { 0, "Association Notification"                                 },
>         { 1, "Battery Level Reporting"                                  },
>         { 2, "Send Battery Level Report on Start-up Synchronization"    },
> @@ -3377,10 +3256,7 @@ static const struct {
>         { }
>  };
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} mesh_oob_table[] = {
> +static const struct bitfield_data mesh_oob_table[] = {
>         { 0, "Other"                                                    },
>         { 1, "Electronic / URI"                                         },
>         { 2, "2D machine-readable code"                                 },
> @@ -3399,7 +3275,6 @@ static const struct {
>  static void print_mesh_beacon(const uint8_t *data, uint8_t len)
>  {
>         uint16_t oob;
> -       int i;
>
>         print_hex_field("Mesh Beacon", data, len);
>
> @@ -3419,10 +3294,7 @@ static void print_mesh_beacon(const uint8_t *data, uint8_t len)
>                 oob = get_be16(data + 17);
>                 print_field("  OOB Information: 0x%4.4x", oob);
>
> -               for (i = 0; mesh_oob_table[i].str; i++) {
> -                       if (oob & (1 << mesh_oob_table[i].bit))
> -                               print_field("    %s", mesh_oob_table[i].str);
> -               }
> +               print_bitfield(4, oob, mesh_oob_table);
>
>                 if (len < 23) {
>                         packet_hexdump(data + 18, len - 18);
> @@ -3626,7 +3498,6 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
>                 uint8_t data_len;
>                 char name[239], label[100];
>                 uint8_t flags, mask;
> -               int i;
>
>                 /* Check for the end of EIR */
>                 if (field_len == 0)
> @@ -3645,18 +3516,10 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
>                 switch (eir[1]) {
>                 case BT_EIR_FLAGS:
>                         flags = *data;
> -                       mask = flags;
>
>                         print_field("Flags: 0x%2.2x", flags);
>
> -                       for (i = 0; eir_flags_table[i].str; i++) {
> -                               if (flags & (1 << eir_flags_table[i].bit)) {
> -                                       print_field("  %s",
> -                                                       eir_flags_table[i].str);
> -                                       mask &= ~(1 << eir_flags_table[i].bit);
> -                               }
> -                       }
> -
> +                       mask = print_bitfield(2, flags, eir_flags_table);
>                         if (mask)
>                                 print_text(COLOR_UNKNOWN_SERVICE_CLASS,
>                                         "  Unknown flags (0x%2.2x)", mask);
> @@ -3822,18 +3685,10 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
>                                 break;
>
>                         flags = *data;
> -                       mask = flags;
>
>                         print_field("  Features: 0x%2.2x", flags);
>
> -                       for (i = 0; eir_3d_table[i].str; i++) {
> -                               if (flags & (1 << eir_3d_table[i].bit)) {
> -                                       print_field("    %s",
> -                                                       eir_3d_table[i].str);
> -                                       mask &= ~(1 << eir_3d_table[i].bit);
> -                               }
> -                       }
> -
> +                       mask = print_bitfield(4, flags, eir_3d_table);
>                         if (mask)
>                                 print_text(COLOR_UNKNOWN_FEATURE_BIT,
>                                         "      Unknown features (0x%2.2x)", mask);
> @@ -4838,7 +4693,7 @@ static void set_event_mask_cmd(const void *data, uint8_t size)
>  {
>         const struct bt_hci_cmd_set_event_mask *cmd = data;
>
> -       print_event_mask(cmd->mask);
> +       print_event_mask(cmd->mask, events_table);
>  }
>
>  static void set_event_filter_cmd(const void *data, uint8_t size)
> @@ -5584,7 +5439,7 @@ static void set_event_mask_page2_cmd(const void *data, uint8_t size)
>  {
>         const struct bt_hci_cmd_set_event_mask_page2 *cmd = data;
>
> -       print_event_mask_page2(cmd->mask);
> +       print_event_mask(cmd->mask, events_page2_table);
>  }
>
>  static void read_location_data_rsp(const void *data, uint8_t size)
> @@ -6261,7 +6116,7 @@ static void le_set_event_mask_cmd(const void *data, uint8_t size)
>  {
>         const struct bt_hci_cmd_le_set_event_mask *cmd = data;
>
> -       print_event_mask_le(cmd->mask);
> +       print_event_mask(cmd->mask, events_le_table);
>  }
>
>  static void le_read_buffer_size_rsp(const void *data, uint8_t size)
> @@ -6826,20 +6681,14 @@ static void le_read_phy_rsp(const void *data, uint8_t size)
>         print_le_phy("RX PHY", rsp->rx_phy);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} le_phys[] = {
> +static const struct bitfield_data le_phys[] = {
>         {  0, "LE 1M"   },
>         {  1, "LE 2M"   },
>         {  2, "LE Coded"},
>         { }
>  };
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} le_phy_preference[] = {
> +static const struct bitfield_data le_phy_preference[] = {
>         {  0, "No TX PHY preference"    },
>         {  1, "No RX PHY preference"    },
>         { }
> @@ -6848,18 +6697,11 @@ static const struct {
>  static void print_le_phys_preference(uint8_t all_phys, uint8_t tx_phys,
>                                                         uint8_t rx_phys)
>  {
> -       int i;
> -       uint8_t mask = all_phys;
> +       uint8_t mask;
>
>         print_field("All PHYs preference: 0x%2.2x", all_phys);
>
> -       for (i = 0; le_phy_preference[i].str; i++) {
> -               if (all_phys & (((uint8_t) 1) << le_phy_preference[i].bit)) {
> -                       print_field("  %s", le_phy_preference[i].str);
> -                       mask &= ~(((uint64_t) 1) << le_phy_preference[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, all_phys, le_phy_preference);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
>                                                         " (0x%2.2x)", mask);
> @@ -6867,13 +6709,7 @@ static void print_le_phys_preference(uint8_t all_phys, uint8_t tx_phys,
>         print_field("TX PHYs preference: 0x%2.2x", tx_phys);
>         mask = tx_phys;
>
> -       for (i = 0; le_phys[i].str; i++) {
> -               if (tx_phys & (((uint8_t) 1) << le_phys[i].bit)) {
> -                       print_field("  %s", le_phys[i].str);
> -                       mask &= ~(((uint64_t) 1) << le_phys[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, tx_phys, le_phys);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
>                                                         " (0x%2.2x)", mask);
> @@ -6881,13 +6717,7 @@ static void print_le_phys_preference(uint8_t all_phys, uint8_t tx_phys,
>         print_field("RX PHYs preference: 0x%2.2x", rx_phys);
>         mask = rx_phys;
>
> -       for (i = 0; le_phys[i].str; i++) {
> -               if (rx_phys & (((uint8_t) 1) << le_phys[i].bit)) {
> -                       print_field("  %s", le_phys[i].str);
> -                       mask &= ~(((uint64_t) 1) << le_phys[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, rx_phys, le_phys);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
>                                                         " (0x%2.2x)", mask);
> @@ -6986,10 +6816,7 @@ static void le_set_adv_set_rand_addr(const void *data, uint8_t size)
>         print_addr("Advertising random address", cmd->bdaddr, 0x00);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} ext_adv_properties_table[] = {
> +static const struct bitfield_data ext_adv_properties_table[] = {
>         {  0, "Connectable"             },
>         {  1, "Scannable"               },
>         {  2, "Directed"        },
> @@ -7258,29 +7085,18 @@ static void le_remove_adv_set_cmd(const void *data, uint8_t size)
>         print_handle(cmd->handle);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} periodic_adv_properties_table[] = {
> +static const struct bitfield_data periodic_adv_properties_table[] = {
>         {  6, "Include TxPower"         },
>         { }
>  };
>
>  static void print_periodic_adv_properties(uint16_t flags)
>  {
> -       uint16_t mask = flags;
> -       int i;
> +       uint16_t mask;
>
>         print_field("Properties: 0x%4.4x", flags);
>
> -       for (i = 0; periodic_adv_properties_table[i].str; i++) {
> -               if (flags & (1 << periodic_adv_properties_table[i].bit)) {
> -                       print_field("  %s",
> -                                       periodic_adv_properties_table[i].str);
> -                       mask &= ~(1 << periodic_adv_properties_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, flags, periodic_adv_properties_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_ADV_FLAG,
>                                 "  Unknown advertising properties (0x%4.4x)",
> @@ -7335,10 +7151,7 @@ static void le_set_periodic_adv_enable_cmd(const void *data, uint8_t size)
>         print_handle(cmd->handle);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} ext_scan_phys_table[] = {
> +static const struct bitfield_data ext_scan_phys_table[] = {
>         {  0, "LE 1M"           },
>         {  2, "LE Coded"                },
>         { }
> @@ -7397,13 +7210,10 @@ static void le_set_ext_scan_enable_cmd(const void *data, uint8_t size)
>                                                 le16_to_cpu(cmd->period));
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} ext_conn_phys_table[] = {
> +static const struct bitfield_data ext_conn_phys_table[] = {
>         {  0, "LE 1M"           },
>         {  1, "LE 2M"           },
> -       {  2, "LE Coded"                },
> +       {  2, "LE Coded"        },
>         { }
>  };
>
> @@ -9478,10 +9288,7 @@ static void le_phy_update_complete_evt(const void *data, uint8_t size)
>         print_le_phy("RX PHY", evt->rx_phy);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} ext_adv_report_evt_type[] = {
> +static const struct bitfield_data ext_adv_report_evt_type[] = {
>         {  0, "Connectable"             },
>         {  1, "Scannable"               },
>         {  2, "Directed"        },
> @@ -10606,10 +10413,7 @@ static void mgmt_print_address(const uint8_t *address, uint8_t type)
>         }
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} mgmt_address_type_table[] = {
> +static const struct bitfield_data mgmt_address_type_table[] = {
>         {  0, "BR/EDR"          },
>         {  1, "LE Public"       },
>         {  2, "LE Random"       },
> @@ -10618,18 +10422,11 @@ static const struct {
>
>  static void mgmt_print_address_type(uint8_t type)
>  {
> -       uint8_t mask = type;
> -       int i;
> +       uint8_t mask;
>
>         print_field("Address type: 0x%2.2x", type);
>
> -       for (i = 0; mgmt_address_type_table[i].str; i++) {
> -               if (type & (1 << mgmt_address_type_table[i].bit)) {
> -                       print_field("  %s", mgmt_address_type_table[i].str);
> -                       mask &= ~(1 << mgmt_address_type_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, type, mgmt_address_type_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_ADDRESS_TYPE, "  Unknown address type"
>                                                         " (0x%2.2x)", mask);
> @@ -10645,10 +10442,7 @@ static void mgmt_print_manufacturer(uint16_t manufacturer)
>         packet_print_company("Manufacturer", manufacturer);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} mgmt_options_table[] = {
> +static const struct bitfield_data mgmt_options_table[] = {
>         {  0, "External configuration"                  },
>         {  1, "Bluetooth public address configuration"  },
>         { }
> @@ -10656,27 +10450,17 @@ static const struct {
>
>  static void mgmt_print_options(const char *label, uint32_t options)
>  {
> -       uint32_t mask = options;
> -       int i;
> +       uint32_t mask;
>
>         print_field("%s: 0x%8.8x", label, options);
>
> -       for (i = 0; mgmt_options_table[i].str; i++) {
> -               if (options & (1 << mgmt_options_table[i].bit)) {
> -                       print_field("  %s", mgmt_options_table[i].str);
> -                       mask &= ~(1 << mgmt_options_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, options, mgmt_options_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Unknown options"
>                                                         " (0x%8.8x)", mask);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} mgmt_settings_table[] = {
> +static const struct bitfield_data mgmt_settings_table[] = {
>         {  0, "Powered"                 },
>         {  1, "Connectable"             },
>         {  2, "Fast Connectable"        },
> @@ -10699,18 +10483,11 @@ static const struct {
>
>  static void mgmt_print_settings(const char *label, uint32_t settings)
>  {
> -       uint32_t mask = settings;
> -       int i;
> +       uint32_t mask;
>
>         print_field("%s: 0x%8.8x", label, settings);
>
> -       for (i = 0; mgmt_settings_table[i].str; i++) {
> -               if (settings & (1 << mgmt_settings_table[i].bit)) {
> -                       print_field("  %s", mgmt_settings_table[i].str);
> -                       mask &= ~(1 << mgmt_settings_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, settings, mgmt_settings_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_SETTINGS_BIT, "  Unknown settings"
>                                                         " (0x%8.8x)", mask);
> @@ -10760,10 +10537,7 @@ static void mgmt_print_io_capability(uint8_t capability)
>         print_field("Capability: %s (0x%2.2x)", str, capability);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} mgmt_device_flags_table[] = {
> +static const struct bitfield_data mgmt_device_flags_table[] = {
>         {  0, "Confirm Name"    },
>         {  1, "Legacy Pairing"  },
>         {  2, "Not Connectable" },
> @@ -10772,18 +10546,11 @@ static const struct {
>
>  static void mgmt_print_device_flags(uint32_t flags)
>  {
> -       uint32_t mask = flags;
> -       int i;
> +       uint32_t mask;
>
>         print_field("Flags: 0x%8.8x", flags);
>
> -       for (i = 0; mgmt_device_flags_table[i].str; i++) {
> -               if (flags & (1 << mgmt_device_flags_table[i].bit)) {
> -                       print_field("  %s", mgmt_device_flags_table[i].str);
> -                       mask &= ~(1 << mgmt_device_flags_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, flags, mgmt_device_flags_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_DEVICE_FLAG, "  Unknown device flag"
>                                                         " (0x%8.8x)", mask);
> @@ -10811,10 +10578,7 @@ static void mgmt_print_device_action(uint8_t action)
>         print_field("Action: %s (0x%2.2x)", str, action);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} mgmt_adv_flags_table[] = {
> +static const struct bitfield_data mgmt_adv_flags_table[] = {
>         {  0, "Switch into Connectable mode"            },
>         {  1, "Advertise as Discoverable"               },
>         {  2, "Advertise as Limited Discoverable"       },
> @@ -10830,18 +10594,11 @@ static const struct {
>
>  static void mgmt_print_adv_flags(uint32_t flags)
>  {
> -       uint32_t mask = flags;
> -       int i;
> +       uint32_t mask;
>
>         print_field("Flags: 0x%8.8x", flags);
>
> -       for (i = 0; mgmt_adv_flags_table[i].str; i++) {
> -               if (flags & (1 << mgmt_adv_flags_table[i].bit)) {
> -                       print_field("  %s", mgmt_adv_flags_table[i].str);
> -                       mask &= ~(1 << mgmt_adv_flags_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, flags, mgmt_adv_flags_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown advertising flag"
>                                                         " (0x%8.8x)", mask);
> @@ -11991,10 +11748,7 @@ static void mgmt_set_apperance_cmd(const void *data, uint16_t size)
>         print_appearance(appearance);
>  }
>
> -static const struct {
> -       uint8_t bit;
> -       const char *str;
> -} mgmt_phy_table[] = {
> +static const struct bitfield_data mgmt_phy_table[] = {
>         {  0, "1MTX"    },
>         {  1, "1MRX"    },
>         {  2, "2MTX"    },
> @@ -12006,18 +11760,11 @@ static const struct {
>
>  static void mgmt_print_phys(const char *label, uint16_t phys)
>  {
> -       uint16_t mask = phys;
> -       int i;
> +       uint16_t mask;
>
>         print_field("%s: 0x%4.4x", label, phys);
>
> -       for (i = 0; mgmt_phy_table[i].str; i++) {
> -               if (phys & (1 << mgmt_phy_table[i].bit)) {
> -                       print_field("  %s", mgmt_phy_table[i].str);
> -                       mask &= ~(1 << mgmt_phy_table[i].bit);
> -               }
> -       }
> -
> +       mask = print_bitfield(2, phys, mgmt_phy_table);
>         if (mask)
>                 print_text(COLOR_UNKNOWN_PHY, "  Unknown PHYs"
>                                                         " (0x%8.8x)", mask);
> --
> 2.17.1

Applied.


-- 
Luiz Augusto von Dentz
